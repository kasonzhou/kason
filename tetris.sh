#!/bin/bash
# filename: tetris.sh
#
# Author: LKJ
# Date: 2013.5.14
# Email: liungkejin@gmail.com
#

# const value
#======================================fixed value================================#
BXLINES=3;  BXCOLNS=6;  
MAPX=20;    MAPY=10;
NAME=('I' 'S' 'Z' 'L' 'J' 'T' 'O');
FLAG=('2' '2' '2' '4' '4' '4' '1');

declare -A mapflag mapname;
mapflag=([I]=2 [S]=2 [Z]=2 [L]=4 [J]=4 [T]=4 [O]=1);
mapname=([I]=1 [S]=2 [Z]=3 [L]=4 [J]=5 [T]=6 [O]=7);
colorone=(31 32 33 34 35 36 37);
colortwo=(31 32 33 34 35 36 37);

Iax=( 0 0 0 0); Iay=(-1 0 1 2);
Ibx=(-1 0 1 2); Iby=( 0 0 0 0);

Sax=( 1 1 0 0); Say=(-1 0 0 1);
Sbx=(-1 0 0 1); Sby=( 0 0 1 1);

Zax=( 0 0 1 1); Zay=(-1 0 0 1);
Zbx=(-1 0 0 1); Zby=( 1 1 0 0);

Lax=(-1 0 1 1); Lay=( 0 0 0 -1);
Lbx=(-1 0 0 0); Lby=(-1 -1 0 1);
Lcx=(-1 -1 0 1);Lcy=( 1 0 0 0);
Ldx=( 0 0 0 1); Ldy=(-1 0 1 1);

Jax=(-1 0 1 1); Jay=( 0 0 0 1);
Jbx=( 1 0 0 0); Jby=(-1 -1 0 1);
Jcx=(-1 -1 0 1);Jcy=(-1 0 0 0);
Jdx=( 0 0 0 -1);Jdy=(-1 0 1 1);

Tax=(0 0 0 -1); Tay=(-1 0 1 0);
Tbx=(-1 0 1 0); Tby=( 0 0 0 1);
Tcx=( 0 0 0 1); Tcy=(-1 0 1 0);
Tdx=(-1 0 1 0); Tdy=(0 0 0 -1);

Oax=( 0 0 1 1); Oay=( 0 1 0 1);

good_game=(
    '                                                 '
    '                G A M E  O V E R !               '
    '                                                 '
    '                   Score:                        '
    '                                                 '
    '          press   Q   to quit                    '
    '          press   N   to start a new game        '
    '          press   S   to change the level        '
    '          press   R   to replay your game        '
    '                                                 '
);

start_game=(
    '                                                 '
    '               ~~~ T E T R I S ~~~               '
    '                                                 '
    '                  Author:  LKJ                   '
    '                                                 '
    '          press   S   to change the level        '
    '                                                 '
    '             C H O O S E  L E V E L:             '
    '                        1                        '
    '                                                 '
    '         Press <Enter> to start the game         '
    '                                                 '
);

blockarr=(); #record name 和 flag
keyarray=(); #record key-press
#------------------------------------------------------------------------#

#========================================================================#
game_init() { # game_init
    SCLINES=`tput lines`;       # height of your screen
    SCCOLNS=`tput cols`;        # width of your screen

#mainframe 
    mainw=59;               mainh=60;                   # height width
    mainctx=0;              maincty=4;                  # 
    upx=$((SCLINES-62));    dnx=$((SCLINES-1));         # x
    lty=$((SCCOLNS/2-50));  rty=$((lty+61));            # y

#next
    nextw=40;           nexth=16;                 # next heigh width
    ntx=$((upx));       nty=$((rty+2));           # next location
    ntctx=$((ntx+5));   ntcty=$((nty+12));        # next center location

#score 
    scorw=$nextw;       scorh=5;
    scx=$((ntx+20));    scy=$((nty));
    scctx=$((scx+4));   sccty=$((scy+19));

#level
    levew=$nextw;       leveh=5;
    lvx=$((scx+9));     lvy=$((scy));
    lvctx=$((lvx+4));   lvcty=$((lvy+20));

#help
    helpw=$nextw;       helph=21;
    hpx=$((lvx+10));    hpy=$((nty));
    hpctx=$((hpx+4));   hpcty=$((hpy+10));

#map
MAP=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    ); 

#paint_gui
    clear; paint_gui;

    local x=$((RANDOM%7));
    name=${NAME[$((x))]};  
    flag=$((RANDOM%FLAG[$x]+1)); 

    nname='I'; nflag=2; #next graph

    centerx=$mainctx; #
    centery=$maincty;

#
    ax="Iax"; ay="Iay";
}
#------------------------------------------------------------------------#

game_exit() {
    tput rmcup;
    tput cvvis;
    stty echo;
    
    (($#==1)) && echo "window is too small";
    exit 0;
}

#============================paint_block, erase_block, paint_box=================

paint_block() {
    local x=$1 y=$2 crone=$3 crtwo=$4 i

    x=$((upx+x*BXLINES+1));
    y=$((lty+y*BXCOLNS+1));

    echo -ne "\033[$((x));$((y))H\e[${crone}m+---+\e[0m";
    echo -ne "\033[$((x+1));$((y))H\e[${crone}m|\e[${crtwo}m###\e[0m\e[${crone}m|\e[0m";
    echo -ne "\033[$((x+2));$((y))H\e[${crone}m+---+\e[0m";
}

#
erase_block() {
    local x=$1 y=$2

    x=$((upx+x*BXLINES+1));
    y=$((lty+y*BXCOLNS+1));

    echo -ne "\033[$(( x ));$((y))H     ";
    echo -ne "\033[$((x+1));$((y))H     ";
    echo -ne "\033[$((x+2));$((y))H     ";
}

#$1 $2 $3 $4 $5
paint_box() {
    local x=$1 y=$2 w=$3 h=$4 color=$5 i

    echo -ne "\033[$x;$((y))H\e[${color}m+\e[0m";
    echo -ne "\033[$x;$((y+w+1))H\e[${color}m+\e[0m";
    for (( i = 1; i <= w; i++ )); do
        echo -ne "\033[$x;$((y+i))H\e[${color}m-\e[0m";
        echo -ne "\033[$((x+h+1));$((y+i))H\e[${color}m-\e[0m";
    done
    echo -ne "\033[$((x+h+1));$((y))H\e[${color}m+\e[0m";
    echo -ne "\033[$((x+h+1));$((y+w+1))H\e[${color}m+\e[0m";

    for (( i = 1; i <= h; i++ )); do
        echo -ne "\033[$((x+i));$((y))H\e[${color}mI\e[0m";
        echo -ne "\033[$((x+i));$((y+w+1))H\e[${color}mI\e[0m";
    done
}
#---------------------------------------------------------------------------------------

#
paint_gui() {
    ((upx<=0 || lty<=0)) && game_exit 1;

    paint_box $upx $lty $mainw $mainh 34; #
    paint_box $ntx $nty $nextw $nexth 33; #
    paint_box $lvx $lvy $levew $leveh 32; #
    paint_box $scx $scy $scorw $scorh 36; #
    paint_box $hpx $hpy $helpw $helph 31; #

#print score, help
    echo -ne "\033[$((ntx+2));$((nty+17))H\e[34mN E X T\e[0m";

    echo -ne "\033[$((scx+2));$((scy+16))H\e[31mS C O R E\e[0m";
    echo -ne "\033[$((scx+4));$((scy+20))H\e[31m0\e[0m";

    echo -ne "\033[$((lvx+2));$((lvy+16))H\e[31mL E V E L\e[0m";
    echo -ne "\033[$((lvctx));$((lvcty))H\e[31m1\e[0m";

    echo -ne "\033[$((hpx+2));$((hpy+17))H\e[33mH E L P\e[0m";
    echo -ne "\033[$((hpctx));$((hpcty))H\e[34mH --- Move Left\e[0m";
    echo -ne "\033[$((hpctx+2));$((hpcty))H\e[34mL --- Move Right\e[0m";
    echo -ne "\033[$((hpctx+4));$((hpcty))H\e[34mJ --- Soft Drop\e[0m";
    echo -ne "\033[$((hpctx+6));$((hpcty))H\e[34mK --- Rotate\e[0m";
    echo -ne "\033[$((hpctx+8));$((hpcty))H\e[34mSpace or Enter --- Hard Drop\e[0m";

    echo -ne "\033[$((hpctx+11));$((hpcty))H\e[34mP --- Pause Game\e[0m";
    echo -ne "\033[$((hpctx+13));$((hpcty))H\e[34mQ --- Quit Game\e[0m";
    echo -ne "\033[$((hpctx+15));$((hpcty))H\e[34mE --- Exit Replay\e[0m";
}

#---------------------------------------------------------

#
paint_next() {
    (($#==0)) && mk_random;
    local oflag=$flag oname=$name

    ((centerx=mainctx+2)); ((centery=maincty+9));
    erase_x;
    flag=$nflag;  name=$nname;

    paint_x;
    flag=$oflag;  name=$oname;
    centerx=$mainctx; centery=$maincty;
}

# 
paint_score() {
    level=0;
    echo -ne "\033[$((scctx));$((sccty))H\e[31m$score\e[0m";
    ((score>2000 )) && ((level=1)); ((score>5000 )) && ((level=2));
    ((score>9000 )) && ((level=3)); ((score>14000)) && ((level=4));
    ((score>20000)) && ((level=5)); ((score>27000)) && ((level=6));
    ((score>35000)) && ((level=7)); ((score>44000)) && ((level=8));
    ((level=olevel+level)); 
    ((level>9)) && ((level=9));

    ((TIME=10-level));
    echo -ne "\033[$((lvctx));$((lvcty))H\e[31m$level\e[0m";
}

#
paint_x() {
    local x=$centerx y=$centery i
    local n=$((${mapname[$name]}-1));

    find_array;
    for (( i = 0; i < 4; i++ )); do
        paint_block $((x+${ax}[$i])) $((y+${ay}[$i])) ${colorone[$n]} ${colortwo[$n]}
    done
}

#
erase_x() {
    local x=$centerx y=$centery i

    find_array;
    for (( i = 0; i < 4; i++ )); do
        erase_block $((x+${ax}[$i])) $((y+${ay}[$i]));
    done
}

rotate_x() {
    ((flag+=1));
    ((flag>mapflag[$name])) && flag=1;
}
#------------------------------------------------------------------------#

#========================================================================#
update() { #update the map
    local x=$1 n=0 i j
    for (( i = 0; i < MAPY; i++ )); do
        erase_block $x $i;              #
        MAP[$((x*MAPY+i))]=0;           #
    done

    #
    for (( i = 0; i < MAPY; i++ )); do
        for (( j = x; j > 0; j-- )); do
            ((n=MAP[$(((j-1)*MAPY+i))])); 
            if ((n!=0)); then
                erase_block $((j-1)) $i;
                paint_block $j $i ${colorone[$((n-1))]} ${colortwo[$((n-1))]};
            fi
        done
    done

    # 
    for (( i = 0; i < MAPY; i++ )); do
        for (( j = x; j >0; j-- )); do
            MAP[$((j*MAPY+i))]=$((MAP[$(((j-1)*MAPY+i))]));
        done
    done
}

#
have_score() {
    local n=0 i j;
    for (( i = 0; i < MAPX; i++ )); do
        for (( j = 0; j < MAPY; j++ )); do
            ((MAP[$((10*i+j))]==0)) && break; #
        done
        ((j==MAPY)) && ((n+=1)) && update $i;    #
    done

    case $n in
        1) ((score+=100)); ;;
        2) ((score+=200)); ;;
        3) ((score+=400)); ;;
        4) ((score+=800)); ;;
    esac
}

#
find_array() {
    case $flag in
        1) ax="${name}ax"; ay="${name}ay";
            ;;
        2) ax="${name}bx"; ay="${name}by";
            ;;
        3) ax="${name}cx"; ay="${name}cy";
            ;;
        4) ax="${name}dx"; ay="${name}dy";
            ;;
    esac
}

# 
check_first() { 
    local x=$centerx y=$centery minx=0 i

    find_array;
# 
    for (( i = 0; i < 4; i++ )); do
        (((x+${ax}[$i])<minx)) && ((minx=(x+${ax}[$i])));
    done
    ((centerx-=minx));
    paint_x;  #
    paint_score;

# 
    for (( i = 0; i < 4; i++ )); do
        ((x=centerx+${ax}[$i])); ((y=centery+${ay}[$i]))
        ((MAP[$((x*10+y))]!=0)) && return 1; #
    done
 
    return 0;
}

#
check_stop() {
    local sx=$centerx sy=$centery
    local x=0 y=0 n=0 i=0
   
    find_array;
    for (( i = 0; i < 4; i++ )); do
        ((x=(sx+${ax}[$i]))); ((y=(sy+${ay}[$i])));
        ((x+1>19)) && break; #
        ((MAP[$((10*(x+1)+y))] != 0)) && break; #
    done
    
    if ((i!=4)); then #
        for (( i = 0; i < 4; i++ )); do
            ((x=(sx+${ax}[$i]))); ((y=(sy+${ay}[$i])));
            n=$((10*x+y)); MAP[$n]=${mapname[$name]};
        done
        have_score;

        return 1;
    fi
 
    return 0;
}

#
check_next() {
    local sx=$1 sy=$2 
    local x=0 y=0 n=0 i=0
    
    find_array;
    for (( i = 0; i < 4; i++ )); do
        ((x=(sx+${ax}[$i]))); ((y=(sy+${ay}[$i])));

        ((x<0 || x>19 || y<0 || y>9)) && return 1; 
        ((MAP[$((10*x+y))] != 0)) && return 1; #
    done

    return 0;
}
#------------------------------------------------------------------------#

#========================================================================#
go_left() { #
    check_next $centerx $((centery-1));
    (($?==1)) && return 1;

    erase_x; ((centery-=1));
    return 0;
}
    
go_right() { #
    check_next $centerx $((centery+1));
    (($?==1)) && return 1;

    erase_x; ((centery+=1));
    return 0;
}

go_down() { #
    check_next $((centerx+1)) $centery
    (($?==1)) && return 1;

    erase_x; ((centerx+=1));
    return 0;
}

go_rotate() { #
    local oflag=$flag #

    rotate_x;
    check_next $centerx $centery;
    (($?==1)) && ((flag=oflag)) && return 1;

    flag=$oflag;
    erase_x; rotate_x;

    return 0;
}

go_fast() { #
    erase_x;
    check_next $((centerx+1)) $centery
    local res=$?;

    while ((res==0)); do
        ((centerx+=1));
        check_next $((centerx+1)) $centery
        res=$?;
    done
}

game_pause() {
    echo -ne "\033[$((hpctx+17));$((hpcty+5))H\e[31mGame Paused\e[0m";
    local pkey;
    while true; do
        read -n 1 pkey;
        [[ $pkey = 'q' ]] || [[ $pkey == 'Q' ]] && game_exit;
        [[ $pkey = 'p' ]] || [[ $pkey == 'P' ]] && break;
    done
    echo -ne "\033[$((hpctx+17));$((hpcty+5))H\e[31m           \e[0m";
}
        
# 
keypress() {
    local result=0;
    case ${key:-space} in
        H|h) go_left;   result=$?; # 
            ;;
        J|j) go_down;   result=$?; # 
            ;;
        K|k) go_rotate; result=$?; # 90
            ;;
        L|l) go_right;  result=$?; #
            ;;
        Q|q) game_exit; # 
            ;;
        P|p) game_pause;
            ;;
        space)  
            go_fast;    nextbk=1;
            ;;
    esac
    ((result==0)) && paint_x;
}
#----------------------------------------------------------------#

#================================================================#
mk_random() { #
    local x=$((RANDOM%7))

    nname=${NAME[$x]};
    nflag=$((RANDOM%FLAG[$x]+1));
}

#
new_game() {
    local i gmover=0 nextbk=0;

    game_init; #
    while true; do
        paint_next; #
        blockarr+=($name $flag $nname $nflag);

        check_first; (($?==1)) && return; #

        while true; do
            for (( i = 0; i < TIME; i++ )); do
                read -n 1 -t 0.1 key; #
                (($?==0)) && keypress; 
                (($?==0)) && keyarray+=(${key:-space});
                (($?==0)) || keyarray+=("nothing");

                ((nextbk==1)) && !((nextbk=0)) && break;
            done

            check_stop; (($?==1)) && break;
            erase_x; ((centerx+=1)); paint_x;
        done
        
        name=$nname; flag=$nflag;
        ((score+=10));
    done
}

replay() {
    score=0; level=$olevel;
    local gmover=0 nextbk=0 i=0 j=0;
    local blocklen=$((${#blockarr[@]})) keylen=${#keyarray[@]};

    game_init;
    for ((i=0; i<blocklen; i+=4)); do
        name=${blockarr[i]}; flag=${blockarr[i+1]};
        nname=${blockarr[i+2]}; nflag=${blockarr[i+3]};

        paint_next -n;
        check_first; (($?==1)) && return 0;

        while true; do
            local k=0 anykey;
            while true; do
                key=${keyarray[j++]}; [[ $key = [pP] ]] && continue;
                keypress; 
                #((j+=1));

                read -n 1 -t 0.1 anykey; 
                if (($?==0)); then 
                    [[ $anykey = [pP] ]] && game_pause;
                    [[ $anykey = [qQ] ]] && game_exit;
                    [[ $anykey = [eE] ]] && level=1 && return 0;
                fi

                ((nextbk==1)) && !((nextbk=0)) && break;
                ((k+=1)) && ((k==TIME)) && break;
            done
 
            check_stop; (($?==1)) && break;
            erase_x; ((centerx+=1)); paint_x;
        done
        ((score+=10));
    done

    score=0; level=1;
    return 0;
}

paint_game_over() {
    local xcent=$((`tput lines`/2)) ycent=$((`tput cols`/2))
    local x=$((xcent-4)) y=$((ycent-25))
    for (( i = 0; i < 10; i++ )); do
        echo -ne "\033[$((x+i));${y}H\e[44m${good_game[$i]}\e[0m";
    done
    echo -ne "\033[$((x+3));$((ycent+1))H\e[44m${score}\e[0m";
}

game_over() {
    paint_game_over;

    level=1; local pkey;
    while true; do
        read -n 1 pkey;
        [[ $pkey = 'q' ]] || [[ $pkey = 'Q' ]] && game_exit;
        [[ $pkey = 'n' ]] || [[ $pkey = 'N' ]] && break;
        [[ $pkey = 's' ]] || [[ $pkey = 'S' ]] && ((level=level%9+1));
        [[ $pkey = 'r' ]] || [[ $pkey = 'R' ]] && replay && paint_game_over;
        echo -ne "\033[$((lvctx));$((lvcty))H\e[31m$level\e[0m";
    done
    olevel=$level;
    blockarr=();
    keyarray=();
}

game_start() {
    tput civis; stty -echo;
    tput smcup; clear;
    trap 'game_exit;' SIGINT SIGTERM

    score=0; #
    level=1; #
    TIME=9;

    local xcent=$(tput lines) ycent=$(tput cols)
    local n=$((xcent/BXLINES)) m=$((ycent/BXCOLNS)) i j;
    for (( i = 3; i < n-2; i++ )); do
        for (( j = 3; j < m-3; ++j)); do
            paint_block $i $j $((RANDOM%7+31)) $((RANDOM%7+31))
        done
    done

    local x=$((xcent/2-4)) y=$((ycent/2-25))
    for (( i = 0; i < 12; i++ )); do
        echo -ne "\033[$((x+i));${y}H\e[40m${start_game[$i]}\e[0m";
    done

    local pkey='x';
    while true; do
        read -n 1 pkey;
        [[ ${pkey:-enter} = 'enter' ]] && break;
        [[ $pkey = 'q' ]] || [[ $pkey = 'Q' ]] && game_exit;
        [[ $pkey = 's' ]] || [[ $pkey = 'S' ]] && ((level=level%9+1));
        echo -ne "\033[$((x+8));$((ycent/2-1))H\e[40m$level\e[0m";
    done
    olevel=$level;
}

game_main() {
    game_start;
    while true; do
        new_game;
        game_over;
    done
}
#----------------------------------------------------------------------#

game_main;
