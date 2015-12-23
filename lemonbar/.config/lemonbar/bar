#!/usr/bin/env bash

###################
# Inital Settings #
###################

panel_dimensions="1920x25+0+0"
barpid="$$"

#colors and fonts
. $HOME/scripts/templates/colors
. $HOME/scripts/templates/fonts
color_bg="$background"
color_fg="$foreground"
invert_bg="$darkgrey"
invert_fg="$background"
pacheck_color="$magenta"

#check if panel is already running
if [ $(pgrep -cx lemonbar) -gt 0 ] ; then
	printf "%s\n" "The panel is already running." >&2
	exit 1
fi

#stop processes on kill
trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

# remove old panel fifo, create new one
fifo="/tmp/panel_fifo"
[ -e "$fifo" ] && rm "$fifo"
mkfifo "$fifo"

###################
#     Applets     #
###################

workspaces() {
    #get workspace names and current workspace
    spaces=($(xprop -root _NET_DESKTOP_NAMES | awk '{$1=$2=""; print $0}' | sed -e 's/,//g' -e 's/\"//g' -e 's/^[[:space:]]*//'))
    current=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')

    #echo workspaces, change color for the current workspace
    for ((i=0;i<${#spaces[*]};i++)) do
        if [ "$i" = "$current" ]; then
            spaces[$i]="%{A1:i3-msg -q workspace ${spaces[$i]}:}%{B$invert_bg}%{F$invert_fg}  ${spaces[$i]}  %{B-}%{F-}%{A}"
        else
            spaces[$i]="%{A1:i3-msg -q workspace ${spaces[$i]}:}  ${spaces[$i]}  %{A}"
        fi
    done

    #remove extra spaces
    myspaces=$(sed -e 's/\(}\).?\(%\)/\1\2/' <<< "${spaces[*]}")

    printf "%s\n" "workspaces%{A4:i3-msg -q workspace prev:}%{A5:i3-msg -q workspace next:}${myspaces}%{A}%{A}"
}

#mpd current song with mouse controls
media() {
    printf "%s\n" "media%{A1:mpc -q prev:}%{A2:mpc -q toggle:}%{A3:mpc -q next:}%{A4:mpc -q volume -5:}%{A5:mpc -q volume +5:}%{F$blue}$(mpc current)%{F-}%{A}%{A}%{A}%{A}%{A}"
}

#check for updates for pacman and yaourt
pacheck() {
    #check for updates
        list=($(checkupdates))
        size=${#list[@]}

    #if updates are available, list the number of packages, otherwise show just icon
    if [[ "$size" -gt 0 ]]; then
        printf "%s\n" "pacheck%{A1:urxvt -g 70x20 -name floating -e yaourt -Syua && kill \$(pgrep sleep):}%{F$pacheck_color}$size%{F-}%{A}"
    else
        printf "%s\n" "pacheck%{A1:kill \$(pgrep sleep):}%{A}"
    fi
}

volume() {
    volume=$(amixer sget Master | sed -n "0,/.*\[\([0-9]\+\)%\].*/s//\1/p")
    state=$(amixer sget Master | grep -Eoe '\[(on|off)\]' | head -n 1)

    if   [[ $volume -eq 0 || $state == '[off]' ]]; then
        token=' '
        volume='-'
    elif [[ $volume -lt 10 ]]; then
        token=' '
    else
        token=''
    fi

    printf "%s\n" "volume%{A3:amixer -q sset Master toggle:}%{A5:amixer -q sset Master 5%+:}%{A4:amixer -q sset Master 5%-:}$token $volume%{A}%{A}%{A}"
}

clock() {
    time1=$(date '+%I:%M')

    printf "%s\n" "clock%{B$invert_bg}%{F$invert_fg}  $time1  %{F-}%{B-}"
}

#launches rofi
launcher() {
    printf "%s\n" "launcher%{A1:rofi -show run &:}%{B$invert_bg}%{F$invert_fg}    %{F-}%{B-}%{A}"
}

#run each applet in subshell and output to fifo
while :; do workspaces; sleep 0.1s; done > "$fifo" &
while :; do media; mpc idle player; done > "$fifo" &
while :; do pacheck; sleep 60m; done > "$fifo" &
while :; do volume; sleep 0.5s; done > "$fifo" &
while :; do clock; sleep 30s; done > "$fifo" &
while :; do launcher; break; done > "$fifo" &

#################
# Build the bar #
#################

while read -r line ; do
    case $line in
        workspaces*)
            workspaces="${line:10}"
            ;;
        media*)
            media="${line:5}"
            ;;
        pacheck*)
            pacheck="  ${line:7}  "
            ;;
        volume*)
            volume="  ${line:6}  "
            ;;
        clock*)
            clock="  ${line:5}"
            ;;
        launcher*)
            launcher="${line:8}"
            ;;
    esac
    printf "%s\n" "${workspaces}%{c}${media}%{r}${pacheck}${volume}${clock}${launcher}"
done < "$fifo" | lemonbar \
    -g "$panel_dimensions" \
    -f "$font_bar:size=$font_bar_size" \
    -f "$backup_font:size=$font_bar_size" \
    -f "$icon_font:size=$font_bar_size" \
    -a 20 \
    -B "$color_bg" \
    -F "$color_fg" \
    | bash; exit
