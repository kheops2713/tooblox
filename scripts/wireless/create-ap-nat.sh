#!/bin/bash
#
# Script to create a cleartext AP and NAT the traffic
# to the internet.
# Note: IPv4 only.
#
# Needed info:
# - wifi interface where to create AP
# - Subnet & netmask of LAN to create (the AP will take the first IP in the subnet)
# - MAC address of AP (optional: will use the physical one if not set)
# - SSID of the network we create
# - wifi channel (often in range 1-12)
# - address of DNS server to announce to the clients
#
# Requirements:
# - a working wifi interface that can be an AP
# - udhcpd
# - hostapd
# - iptables
# - iproute2 ('ip' command)
# - sysctl
# - uuidgen

## <CONFIG> ##

AP_IF=wlan1
SSID="Free Tunisia"
CHANNEL=8
MAC=
PSK=

SUBNET=192.168.56.0
NETMASK_BITS=24

# Try tell clients to use the NS that we use in /etc/resolv.conf
# Note: many modern distros don't use /etc/resolv.conf anymore so it may fail 
DNS=$(egrep ^nameserver /etc/resolv.conf | head -n 1 | awk {'print $2'})

## </CONFIG> ##

padbin ()
{
    local bin=$1
    local pad=$2

    local len=${#bin}
    while [ $len -lt $pad ]; do
	bin=0$bin
	len=$(($len + 1))
    done

    echo $bin
}

dec2bin ()
{
    local tmp=$1
    local pad=$2
    local bin=""
    
    while [ $tmp != 0 ]; do
	if [ $(($tmp%2)) = 1 ]; then
	    bin=1${bin}
	    tmp=$(($tmp - 1))
	    tmp=$(($tmp / 2))
	else
	    bin=0${bin}
	    tmp=$((tmp / 2))
	fi
    done

    if [ -z "$bin" ]; then
	bin=0
    fi

    if [ -n "$pad" ]; then
	bin=$(padbin $bin $pad)
    fi

    echo $bin
}

bin2dec ()
{
    local bin=$1
    local dec=0
    local len=${#bin}
    local lentmp=${#bin}

    while [ $lentmp -gt 0 ]; do
	local pwr=$(($len - $lentmp))
	lentmp=$(($lentmp - 1))

	# following line does not work with dash... FFUUUU
	local digit=${bin:$lentmp:1}
	dec=$(($dec + ($digit * (2**$pwr) )))
    done

    echo $dec
}

ip2bin ()
{
    local ip=$1
    local result=""
    for ((i = 1; $i <= 4; i++)); do
	local cur=$(echo -n $ip | cut -d . -f $i)
	local curbin=$(dec2bin $cur 8)
	result=${result}${curbin}
    done
    
    echo $result
}

bin2ip ()
{
    local bin=$(padbin $1 32)
    local pos=0
    local ip=""
    while [ $pos -lt 24 ]; do
	ip=${ip}$(bin2dec ${bin:$pos:8}).
	pos=$(($pos + 8))
    done
    ip=${ip}$(bin2dec ${bin:$pos:8})

    echo $ip
}



writeconfig ()
{
    echo Creating $HOSTAPD_CFG...

    # Configure hostapd
    echo "interface=$AP_IF
driver=nl80211
ssid=$SSID
hw_mode=g
channel=$CHANNEL
macaddr_acl=0
ignore_broadcast_ssid=0" >$HOSTAPD_CFG

    if [ -n "$PSK" ]; then
      echo "wpa=2
wpa_passphrase=$PSK
wpa_key_mgmt=WPA-PSK" >>$HOSTAPD_CFG
    fi

    echo Creating $UDHCPD_CFG...

    # Configure udhcpd
    echo "pidfile $UDHCPD_PID
start $CLIENT_START
end $CLIENT_END
interface $AP_IF
option router $AP_IP
option dns $DNS
option subnet $NETMASK_IP" >$UDHCPD_CFG
}

up ()
{
    # 1. Config interface MAC address if necessary
    ip link set $AP_IF down
    if [ -n "$MAC" ]; then
	echo Setting MAC of $AP_IF to $MAC...
	ip link set $AP_IF address $MAC
    fi
    ip link set $AP_IF up
    ip addr add $AP_IP/$NETMASK_BITS dev $AP_IF

    # 2. Start hostapd
    echo Starting hostapd
    hostapd -d -B -P $HOSTAPD_PID $HOSTAPD_CFG

    # 3. Start udhcpd
    echo Starting udhcpd
    udhcpd $UDHCPD_CFG
    
    # 4. Add iptables rule and enable forwarding
    iptables -t nat -A POSTROUTING -s $SUBNET/$NETMASK_BITS -j MASQUERADE
    sysctl net.ipv4.ip_forward=1
}

function down
{
    kill $(cat $HOSTAPD_PID)
    kill $(cat $UDHCPD_PID)
    ip addr del $AP_IP/$NETMASK_BITS dev $AP_IF
    ip link set $AP_IF down
    rm -f $HOSTAPD_PID $UDHCPD_PID $HOSTAPD_CFG $UDHCPD_CFG
    iptables -t nat -D POSTROUTING -s $SUBNET/$NETMASK_BITS -j MASQUERADE
    sysctl net.ipv4.ip_forward=$IP4_FWD_PREV
    exit 0
}

if [ -n "$(which uuidgen)" ]; then
    ID=$(uuidgen | cut -d - -f 1)
else
    exit 1
fi

NETMASK_IP=$(bin2ip $(printf '1%.s' $(seq 1 $NETMASK_BITS))$(printf '0%.s' $(seq $NETMASK_BITS 31)))
net_bin=$(ip2bin $SUBNET)
net_prefix_bin=${net_bin:0:$NETMASK_BITS}
AP_IP=$(bin2ip ${net_prefix_bin}$(printf '0%.s' $(seq $NETMASK_BITS 30))1)
CLIENT_START=$(bin2ip $(dec2bin $(($(bin2dec $(ip2bin $AP_IP))+1))))
CLIENT_END=$(bin2ip ${net_prefix_bin}$(printf '1%.s' $(seq $NETMASK_BITS 30))0)

HOSTAPD_CFG=hostapd_$ID.cfg
UDHCPD_CFG=udhcpd_$ID.cfg
HOSTAPD_PID=hostapd_$ID.pid
UDHCPD_PID=udhcpd_$ID.pid

IP4_FWD_PREV=$(sysctl -n net.ipv4.ip_forward)

writeconfig
up
trap down EXIT TERM INT
while [ 1 ]; do sleep 1; done
