#!/bin/bash

CACHE="/home/kheops/.cache/dmenu_web_search"
WPCACHE="/home/kheops/.cache/dmenu_wikipedia"
BROUTEUR="Tor Browser"
DMENU="dmenu -nb #8aafd8 -nf #304c6a -sb #bfd5ee -sf #304c6a -l 10 -c -fn Serif-13"
WPLANGS="fr en de es ja ru it zh pt ar fa pl nl id uk he sv cs ko vi war ceb ca no fi hu tr ro sw kk da zh-min-nan eo sr lt vo sk bg min sl eu et hr ms el arz ur th hi ta bn lmo te nn gl az simple af ht bs be lb ml ka is sq uz la br mk lv azb mr gu sh tg tl cy sco ku ckb ast new bpy nds io pms su oc jv nap ba scn wa bar be-tarask an ksh szl fy frr zh-yue als ia ga yi hy mg gd vec ce pa sa mai xmf sd wuu as mrj mhr km roa-tara am roa-rup map-bms bh my mnw shn bcl co cv dv nds-nl fo hif fur gan glk gu hak ilo kn pam csb avk lij li gv mi mt nah ne nrm se nov qu os pi pag ps pdc rm bat-smg sc si tt to tk hsb fiu-vro vls yo diq zh-classical frp lad kw mn haw ang ln ie wo tpi ty crh nv jbo ay pcd zea eml ky ig or cbk-zam kg arc rmy ab gn so kab ug stq ha udm ext mzn pap cu sah tet sn lo pnb iu na got bo dsb chr cdo om sm ee ti av bm zu pnt cr pih ss ve bi rw ch xh kl ik bug dz ts tn kv tum xal st tw bxr ak ny fj lbe ki za ks ff lg sg rn chy mwl lez bjn gom lrc tyv vep nso kbd ltg rue pfl gag koi krc ace olo kaa mdf myv srn ady jam tcy dty atj kbp din lfn gor inh sat hyw nqo ban szy gcr awa ary lld smn nostalgia mo ng ii cho mh aa mus hz kr ho kj"

broute () {
  wmctrl -a "$BROUTEUR" && \
    sleep 0.2 && \
    xdotool key --delay 20 Ctrl+t Ctrl+l && \
    xdotool type "$1" && \
    xdotool key Return
}

case "$1" in 
  histclean)
    while [ 1 ]; do
      q=$(sort -u $CACHE | $DMENU -p 🧹)
      if [ -z "$q" ]; then
        exit
      fi
      ln=$(grep -xFnm1 "$q" $CACHE | cut -d: -f1)
      if [ "$ln" ]; then
        sed -i ${ln}d $CACHE
      fi
    done
    ;;
  wp)
    lang=$(echo $WPLANGS | tr ' ' '\n' | $DMENU -p 🌐)
    if [ -z "$lang" ]; then exit; fi
    wpterm=$(sort -u $WPCACHE | $DMENU -p 📚)
    if [ -z "$wpterm" ]; then exit; fi
    grep -qxF "$wpterm" $WPCACHE || echo "$wpterm" >>$WPCACHE
    broute "https://${lang}.wikipedia.org/wiki/Special:Search/${wpterm}"
    ;;
  *)
    q=$(sort -u $CACHE | $DMENU -p 🐐)
    if [ -z "$q" ]; then
      exit
    fi
    grep -qxF "$q" $CACHE || echo "$q" >>$CACHE
    broute "$q"
    ;;
esac
