#variables
set \$mod      Mod4
set \$gsi      10
set \$gso      5
set \$bordersize       3

set \$background       $background
set \$foreground       $foreground
set \$black    $black
set \$darkgrey $darkgrey
set \$darkred  $darkred
set \$red      $red
set \$darkgreen        $darkgreen
set \$green    $green
set \$darkyellow       $darkyellow
set \$yellow   $yellow
set \$darkblue $darkblue
set \$blue     $blue
set \$darkmagenta      $darkmagenta
set \$magenta  $magenta
set \$darkcyan $darkcyan
set \$cyan     $cyan
set \$lightgrey        $lightgrey
set \$white    $white

client.focused		\$background \$blue \$background \$yellow
client.focused_inactive	\$blue \$background \$foreground \$darkgrey
client.unfocused	\$background \$background \$foreground \$darkgrey
client.urgent		\$red \$red \$background \$red

#other settings

focus_follows_mouse	no
popup_during_fullscreen	smart
workspace_layout	default

#font
font pango: $font $font_size

#borderstray_output <none|primary|output>
hide_edge_borders	none
gaps			inner \$gsi
gaps			outer \$gso
new_float		pixel \$bordersize
new_window		pixel \$bordersize

#Use Mouse+\$mod to drag floating windows to their wanted position
floating_modifier \$mod

#gaps
gaps inner \$gsi
gaps outer \$gso

#arbitrary commands for specific windows
for_window [class="^.*"] border pixel \$bordersize
#teamviewer
for_window [title="^TeamViewer Panel$"] sticky enable
for_window [title="^TeamViewer$"] move scratchpad
for_window [title="^Computers & Contacts*"] move scratchpad
#steam
for_window [title="Steam - Update News"] floating enable
assign [class="^Steam$"] 
#other
for_window [window_role="pop-up"] floating enable
for_window [instance="floating"] floating enable
for_window [class="mpv"] floating enable
for_window [instance="^imv$"] floating enable

#start a terminal
bindsym \$mod+Return exec urxvt
bindsym Control+\ exec urxvt

#kill focused window
bindsym \$mod+q kill

#change focused window
bindsym \$mod+Left focus left
bindsym \$mod+Down focus down
bindsym \$mod+Up focus up
bindsym \$mod+Right focus right

bindsym \$mod+h focus left
bindsym \$mod+j focus down
bindsym \$mod+k focus up
bindsym \$mod+l focus right

#move focused window
bindsym \$mod+Shift+Left move left
bindsym \$mod+Shift+Down move down
bindsym \$mod+Shift+Up move up
bindsym \$mod+Shift+Right move right

bindsym \$mod+Shift+h move left
bindsym \$mod+Shift+j move down
bindsym \$mod+Shift+k move up
bindsym \$mod+Shift+l move right

#split in horizontal orientation
bindsym \$mod+c split h

#split in vertical orientation
bindsym \$mod+v split v

#enter fullscreen mode for the focused container
bindsym \$mod+f fullscreen toggle

#change container layout (stacked, tabbed, toggle split)
bindsym \$mod+s layout stacking
bindsym \$mod+a layout tabbed
bindsym \$mod+d layout toggle split

#toggle tiling / floating
bindsym \$mod+space floating toggle

#switch to workspace
bindsym \$mod+1 workspace 1
bindsym \$mod+2 workspace 2
bindsym \$mod+3 workspace 3
bindsym \$mod+4 workspace 4
bindsym \$mod+5 workspace 5
bindsym \$mod+comma workspace prev
bindsym \$mod+period workspace next

#move focused container to workspace
bindsym \$mod+Shift+1 move container to workspace 1
bindsym \$mod+Shift+2 move container to workspace 2
bindsym \$mod+Shift+3 move container to workspace 3
bindsym \$mod+Shift+4 move container to workspace 4
bindsym \$mod+Shift+5 move container to workspace 5
bindsym \$mod+Shift+comma move container to workspace prev
bindsym \$mod+Shift+period move container to workspace next

#scratchpad
bindsym \$mod+Shift+t scratchpad show
bindsym \$mod+t move scratchpad


#reload the configuration file
bindsym \$mod+Shift+c reload
#restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym \$mod+Shift+r restart
#exit i3 (logs you out of your X session)
bindsym \$mod+Shift+e exec "i3-nagbar -t warning -m 'Logout?' -b 'Yes' 'i3-msg exit'"

#resize window (you can also use the mouse for that)
mode "resize" {
        #these bindings trigger as soon as you enter the resize mode

        #pressing left will shrink the window’s width.
        #pressing right will grow the window’s width.
        #pressing up will shrink the window’s height.
        #pressing down will grow the window’s height.
        bindsym h resize shrink width 10 px or 10 ppt
        bindsym j resize grow height 10 px or 10 ppt
        bindsym k resize shrink height 10 px or 10 ppt
        bindsym l resize grow width 10 px or 10 ppt

        #same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        #back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
}

bindsym \$mod+r mode "resize"

#launcher
bindsym Control+space exec --no-startup-id rofi -show run

#volume key bindings
bindsym XF86AudioMute exec --no-startup-id "amixer set Master toggle"
bindsym XF86AudioLowerVolume exec --no-startup-id "pactl set-sink-volume 0 -5%"
bindsym XF86AudioRaiseVolume exec --no-startup-id "pactl set-sink-volume 0 +5%"

#startup
exec --no-startup-id compton -CGbz -r 8 -o 0.2 -l -12 -t -12 --backend glx --vsync opengl --shadow-exclude 'argb && _NET_WM_OPAQUE_REGION@:c'
exec --no-startup-id teamviewer

#wallpaper
exec --no-startup-id hsetroot -fill ~/Pictures/Wallpapers/wallpaper.png

#lemonbar
exec --no-startup-id ~/.config/lemonbar/bar
