#!/bin/bash

# inspired from https://github.com/porras/dmenu-emoji
# kaomoji data taken from https://github.com/eylles/dmenukaomoji

# Note: -c options of dmenu requires patched version with centering

set -e

data=$(sed '0,/^__DATA__$/d' "$0")
sel=$(echo "$data" | \
  dmenu -l 10 -c \
  -nb '#ff35a6' \
  -sb '#ee2495' \
  -nf '#000000' \
  -sf '#ffffff' \
  -fn 'sans-16')
emoji=$(echo "$sel" | awk {'print $1'})
echo -n "$emoji" | xclip -selection clipboard
xdotool type "$emoji"

exit

__DATA__
^_^ Overjoyed (2)
(╯°□°)╯︵ ┻━┻ Flipping Table (3)
ლ(ಠ益ಠლ) But At What Cost
(//_^) Emo (5)
ʕ •ᴥ•ʔ Koala (3)
(っ^‿^)っ Kirby (5)
[¬º-°]¬ Zombie (2)
(●∈∋●) Bird (5)
ಠ_ಠ Disapproval
T.T Sad (2)
◤◡ᴥ◡◥  Dog (4)
(∩｀-´)⊃━☆ﾟ.*･｡ﾟ Wizard
^-^ Happy (7)
ᕦ(ò_óˇ)ᕤ Flexing (3)
♪┏(・o･)┛♪ Dancing (8)
( ͡° ͜ʖ ͡°) Smiling (2)
／人◕ ‿‿ ◕人＼ Kyubey
༼ ༎ຶ ෴ ༎ຶ༽ Distraught
ᒄ₍⁽ˆ⁰ˆ⁾₎ᒃ♪♬ Frosty the Snowman (2)
(╯°□°）╯︵ ┻━┻ Flipping table (2)
<(^oo^)> Pig (3)
¯\_(ツ)_/¯ Shrugging (2)
U=･ x ･=U Rabbit (2)
⊂((・▽・))⊃ Hug me (2)
V●ᴥ●V Doggy (2)
(=^_^=) Bunny (3)
<コ:彡 Squid (2)
-_-; Anime Sweat Drop (2)
(°̥̥̥̥̥̥̥̥ᴗ°̥̥̥̥̥̥̥̥) Happy crying
(=^･ｪ･^=) Kitty (2)
(((༼•̫͡•༽))) Ghost (2)
(－‸ლ) Whoops
(=^ェ^=) Cat (4)
( ´-ω･)︻┻┳══━一 Sniper
⊆☉ᴥ☉⊇ Bear (7)
༼ つ ◕_◕ ༽つ Take my energy
( ￣┏＿┓￣) Mustache (2)
(;´Д`) Giving Up
( ͡° ʖ̯ ͡°) Disgruntled
✌(◕‿-)✌ Peace (3)
ಠ_ರೃ Monocle (2)
T^T Crying (5)
ᘛ⁐̤ᕐᐷ Chameleon
༼ つ ◕_◕ ༽つ Gimme
ლ(ಠ益ಠ)ლ Anger
(ง •̀_•́)ง Feisty
(っ⌒‿⌒)っ Hug (3)
ϵ( 'Θ' )϶ Fish (3)
(＾▽＾) Laughing (5)
¯\(°_o)/¯ Confused (4)
̿’̿’\̵͇̿̿\З=( ͠° ͟ʖ ͡°)=Ε/̵͇̿̿/’̿̿ ̿ ̿ ̿ ̿ ̿ Outlaw
o(^▽^)o Pumped (2)
.∵･(ﾟДﾟ) Scared (2)
(＊☉౪ ⊙｡)ﾉ Imbecile (2)
d-(^.^)z Thumbs Up (2)
(>_<) Painful
(¬_¬") Annoyed (4)
(´╹〽╹`) Worried (4)
(o^-^o) Pikachu (2)
(▀̿Ĺ̯▀̿ ̿) Deal with it
(∩｀-´)⊃━☆ﾟ.*･｡ﾟ Magic Attack
꒡ᘦ̲꒡ Sleeping (5)
(‾ʖ̫‾) Lethargic
^_^; Guilty
ヽ(｀⌒´メ)ノ Angry (8)
^^ Blissful
^_^/ High Five (2)
ʕ•͡ᴥ•ʔ Polar bear
❆❅❉ Snowing
ヽ(★ω★)ノ Excited
U＾ェ＾U Puppy
⊂(^(工)^)⊃ Teddy bear
(≧∇≦)/ Joyful (2)
◦°˚\☺/˚°◦ Playing in the snow
(╯°□°)╯︵ ʞooqǝɔɐɟ Flipping Facebook
(;-_-)ノ Giving up
⊙▂⊙ Shocked
|∴め ϖ め∴| SpongeBob SquarePants
◔̯◔ Rolling Eyes
⊂(◜ᴥ◝)つ Teddy Bear
ε=(☉_☉) Accidental farting
(ಥ﹏ಥ) Devastated (2)
(•͡.•͡) Skeptical
ε=┏( >_<)┛ Running (5)
┬─┬﻿︵/(.□.)╯ Table Flips You
〠_〠 Tired (3)
∊ಠ_ಠ∍ Distressed
V=(° °)=V Crab (2)
ᶘ ᵒᴥᵒᶅ Seal (2)
Ƹ̵̡Ӝ̵̨̄Ʒ Butterfly
(- o - ) zzZ ☽ Sleepy
◯０o。(ー。ー)y Smoking (4)
（。々°） Herp Derp
-_-* Frustrated (3)
(+[__]∙:∙) PlayStation Portable
(V) (°,,,,°) (V) Zoidberg
/|\( ;,; )/|\ Bat
◖㈠ ω ㈠◗ Panda
\m/d(^_^)b\m/ Rocking Out
ヽ(ﾟДﾟ)ﾉ Freak Out (2)
(ﾉﾟ0ﾟ)ﾉ~ Yoo-Hoo
¤\( `⌂´ )/¤ Lifting weights
(ò_ó) Furious
( ˘ ³˘)♥ Kiss me
(＾▽＾) Cheerful (3)
(⌒ ͜ʖ⌒)b Attentive
ᕦ❍ᴗ❍ᕤ Muscular Person
(´>_●)メ(●_<｀) Sword Fighting
:-Þ Teasing
＝( ^o^)ノ___ｏ Bowling
(#×_×) Dead (2)
(。･_･)ノ”【】 Painting
（/｡＼) Shy (5)
⎰≀.☮-☮≀⎰ John Lennon
─=≡Σ(([ ⊐•̀⌂•́]⊐ Superhero
（￢з￢）σ Pointing (2)
（・д・）｝ On The Phone (3)
㐈⦁ཽし⦁ཽ㐈  Larry David
⨌⨀_⨀⨌ Benjamin Franklin
(☄ฺ◣д◢)☄ฺ Scaring
ƪ(˘▽˘ƪ) Worshiping
[•.•ิ] Huh
(◐‿◑)﻿ Crazy
＼(-_- ) Thank You
（＿ε＿） Kiss my butt
(⊃‿⊂) Anticipation
(*￣m￣) Dissatisfied
Q('.'Q) Put Em Up
＼(^o)(^0^)(o^)／ Caroling
（￣～￣） Unimpressed
༼ঢ_༽ঢ༽ Perplexed
(｡♥‿♥｡) Smitten
（￣□￣；） Surprised
(^o^) Singing (3)
(:3 っ)っ Walrus
( `_)乂(_' ) Arm wrestle
(ง •̀ゝ•́)ง Fighting (2)
uwu Happy Anime Face
└(^o^ )Ｘ( ^o^)┘ Best buddies
d^_^b DJ
( --)/ ==卍 Ninja Star
Ｃ:。ミ Octopus
(´･ω･`) Snubbing (2)
♪(●′▽`)ﾉ Good Night
(#^.^#) Embarrassed (3)
ಥ_ಥ Bawling (3)
†_(ﾟｰﾟ*)β Exorcism
੯ू•́ू ໒꒱⁼³₌₃ Sonic the Hedgehog
(^‿◕) Winking (3)
(″･ิ_･ิ)っ Wait (3)
｡◕‿◕｡ Gleeful
ヽ( ★ω★)ノ Pumped up
＿〆(。。) Writing (2)
(∿°○°)∿ ︵ ǝʌol Heartbroken
^;;^ Spider
(⓪益⓪) Staring (2)
(￣┏∞┓￣) Fu Manchu Man
( • ∀•)っθΘʘ Hiding Easter eggs
＿φ( °-°)/ Doing Homework
◖ර◞ʖ◟ර◗ Grandma
¬.¬ Whatever (3)
⫷ °⧭° ⫸ Clown
(♥_♥) In Love
>.< Upset (2)
( ◢д◣) Depressed (4)
ᕕ( ᐛ )ᕗ Celebrating
(¬‿¬) Cunning
└(^o^)┐ Grooving (3)
～゜・_・゜～ Raving
ᕦ◉▿◉ᕤ Owl (2)
＼(＾O＾)／ Celebrate
(*’(OO)’*) Piggy (2)
˃ʍ˂ Enraged (2)
(ू˃̣̣̣̣̣̣︿˂̣̣̣̣̣̣ ू) Sobbing (3)
（　＾＾）人（＾＾　） Best Buds
└@(･ｪ･)@┐ Beefcake
(☉__☉”) Yikes
(╯˘ -˘ )╯ Praying (2)
ε=┌( ≧▽)┘ Elated
( •_•)O °Q(•_• ) Playing Ping Pong
∋(°O°)∈ Blowfish
(；一_一) Ashamed (4)
{♥‿♥} Lovestruck
๏-) Cyclops
(o￣∇￣)=◯)`ν゜)･ Punching (6)
┬─┬ノ( º _ ºノ) Putting Table Back (2)
(~_(]=--Z(◡˘) Pie Fight
((((((^_^;) Evading
(／o^)/°⊥＼(^o＼) Volleyball
-{'''|'''|'''|''']=[] Syringe
[^._.^]ﾉ彡 Nyan Cat
---(o_　_)o Tripping (2)
┬┴┬┴┤(･_├┬┴┬┴ Snooper
(ㆆ_ㆆ) Unamused
(✿◠‿◠)  Hippie
ヾ(*￣O￣)ツ Yelling
(ɔ◔‿◔)ɔ ♥ Loving
(ﾉ-o-)ﾉ 中 Olympic Hammer Throw
(/ω･＼) Peering
(´・ω・)っ由 Gift
[-_-]~ Ninja
(シ_ _)シ Apology (2)
∋∞(●ﾟvﾟ)∞∈ Pigtails
‎(>o<)ρミ┳┷┳゜ Table Tennis
(^̮^) Pleased (2)
♪～(￣ε￣；) Whistling
(￣▼￣) Big Grin
⋟^≏^⋞ Kitty Cat
（￣へ￣） Discontent
(*・_・)ノ⌒* Throwing Away
(*@_＊#) Beaten Up
(p_-) Thinking
(。_°)☆ Punched
♥‿♥ Enamored
ε-(´・｀) ﾌ Phew
༼ঢ_㇁ঢ༽ Bad hair day
(づ￣ ³￣)づ Smooch (3)
O(<>'<>)O Aang
(_ _)..ooOO Dreaming
┳┻┳° Ping Pong table
^o^ Mog
(ﾟ皿ﾟ)ｒ┏┳－* Shooting (2)
m( ﾟ皿ﾟ)m★━━ Laser
٩◔̯◔۶ Eye Roll With Hands Up
ヽ(´Д｀ヽミノ´Д｀)ノ Frantic (2)
(-ε- ) Pucker up (3)
ヽ(⌐■_■)ノ♪♬ Boogie down
「(°ヘ°) Puzzled
d(^_^)b Listening to Music
( -_-)旦~ Drinking
<_< Looking (4)
(( ＿ ＿)☆ ≡〇 Header
^)_(^ Chubby
(๑´•.̫ • `๑) Blushing
(｡▼皿▼) Darth Vader
(╬☉Д⊙ฺ) Cyborg
(ʘ‿ʘ) Smile
ε=ε=ε=┌(๑ʘ∀ʘ)┘ Sprinting
ƪ(˘⌣˘)ʃ Raise the roof
( ˘︹˘ ) Smug
(▰˘◡˘▰) Satisfied
(¬､¬) Shifty
¯(°_o)/¯ Confused shrug
✖‿✖ Dead person
（。_°☆＼(- – ) Punch
(ɔˆ ³(ˆ⌣ˆc) Loving couple
(*▿▿* ƪ) Vampire
o(^^o)(o^^)o Hopeful
___ψ(‥ ) Studying
＿φ(°-°=) Doing homework
@( o･ω･)@ Monkey
(╭ರ_•́) Inquisitive
੯ू‵ू ໒꒱ Poodle
(*^^)^*) Kiss (5)
（＾～＾） Meh
(／。＼) Frightened
:þ Playful
(>^_^)><(^o^<) Hugging
(-_ゞ Groggy
(*^o^)人(^o^*) Buddies
(●´ﾉω`)ｺ Whispering (2)
o(´^｀)o Reluctant
（ つ Д ｀） Wiping Tears
(o´・Υ・)ﾉ･ Help (2)
(｡･ˇдˇ･｡) Pompous
(´∪`*) Friendly
ヘ（。□°）ヘ Psycho
（人’∀’） Precious
(っ˘ڡ˘ς) Yummy
┗(･ω･;)┛ How Should I Know
(о＾ω＾о) Giggling
(´ー｀)┌ﾌｯ Golf Clap
\\(<.<|>.>)// Panicking
^(#｀∀´)_Ψ Demon
(╯‵Д′)╯ Scary
:-{  -__-: Stinky
ಠᴗಠ Scheming
<(;￣ ･￣) Scratching
＼（＾ ＾）／ Glad
(╯_╰) Bummed out
┗( ●-﹏ ｀｡)づ Hurt (2)
(-_-)# Girl
8(>_<)8 Jealous
(*°∀°)=3 Infatuated (3)
( ^_^)／ Waving
o(^_-)O Boxer
{{|└(>o< )┘|}} Up In Arms
(^^)// Applause (2)
( `_)?(_' ) Dueling
(´~`) Weary
v(^_^)v Victory (3)
(ﾉ_ _)ﾉ Surrender
<( ･ｪ-)<} Bow and Arrow
( ｀o´)_θ☆ Kicking
(-□-)︵* Blowing a Kiss
|д･) Hiding (4)
（´Д゜）/゜⌒。 Discarding
ʕʔ Bread
(ɔ˘з˘)ɔ Romantic
ʕ •́؈•̀) Winnie the Pooh
(ó ì_í)=óò=(ì_í ò) Bro Pound
ヾ(｀ε´)ﾉ Booing
|̲̅̅●̲̅̅|̲̅̅=̲̅̅|̲̅̅●̲̅̅| Stereo
ʘ‿ʘ Eager
:(¦) Frog
（　＾）／占~~~ Banksy
(;´༎ຶД༎ຶ`) Weeping (2)
⊂ •͡˘∠•͡˘ ⊃ Suspicious
( ° ᴗ°)~ð  Proposal
(๑╹ڡ╹๑) Tasty
(¬_¬ ) Neglected
ʕु•̫͡•ʔु Bear cub (2)
┌|°з°|┘ Cutting a rug
(⊙_◎) Crazed
(✖╭╮✖) Deceased
←～（o ｀▽´ )oΨ Satan
˙ ͜ʟ˙ Content
( ˇ෴ˇ ) Hipster
♫.(◠౪◠).♫ Jamming to music
∊♡_ᴥ_♡∍ Puppy Love
L(´□｀L) Oh No! (2)
(;´ρ`) Yawning
(╯ნ_㇁ნ)╯ Defeated
(.〜◍`皿′◍〜.) Livid (2)
ᡊ|◔じ◔|ᡊ  Woody Allen
✌(გ_㇁გ)✌ Ringo Starr
╹﹏╹ Cold
☉ϖ☉ Lobster
(๑≖ิิ益≖ิ๑) Evil Laugh
(((☎))) Phone
(○｀д´)ﾉｼ Σ(っﾟДﾟ)っ Chasing
o(>< )o⌒* Mad (3)
ლ(´ڡ`ლ) Licking
⪿ ↂ ˒̫̮ ↂ ⫀ Elton John
(•ᴥ• )́`́'́`́'́⻍ Porcupine
且_(ﾟ◇ﾟ；)ノﾞ Waiter
◖⎚∠⎚◗ Geek
-ˆ ω ˆ- Kitten
•:_:• Nagato
ε=┌(^-^)┘ Skipping
(+.+)(-.-)(_ _) Falling Asleep
[ ± _ ± ] Sick
〜〜(／￣▽)／　〜ф Chasing A Butterfly
＼(｀0´)／ Fed Up
¥[*.*]¥ Robot
(*・)σσ(*゜O゜) Poking
(￣ー￣（＿　＿（ Nodding
▼o･_･o▼ Hello
(`_^) Wink
/( ＿0＿)￣θ☆≡≡○ Scissor Kick
ヽ（´ー｀）┌ Mellow
(^ _ ^)/~~ Goodbye
（*・)｢｣｢｣ Magic Casting
( ｀皿´)｡ﾐ/ Hitting
[]゛７(∀゜*） Dialing
(((((^_^) Teleporting
(￣ー￣)//”” Clapping
(。。;)＼(-_-) Comforting
(* ￣)(￣ *)  Kissing
(；^＿^)ッ☆(　゜o゜) Slapping
＼（～Ｏ～）／ Good Morning
\＿(´▽｀)♪＿/ Bathtub
