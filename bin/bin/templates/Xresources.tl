URxvt.saveLines:3000
URxvt.scrollBar: false
URxvt.transparent:false
URxvt.geometry: 85x30
URxvt.internalBorder: 10
URxvt.iso14755 : false

URxvt.perl-ext-common: default,matcher
URxvt.url-launcher: /usr/bin/google-chrome-beta
URxvt.matcher.button: 1

URxvt.font: xft:$font_mono for Powerline:size=12,xft:$font_mono:size=12
URxvt.boldFont: xft:$font_mono_bold for Powerline:bold:size=12,xft:$font_mono_bold:bold:size=12
URxvt.italicFont: xft:$font_mono for Powerline:italic:size=12,xft:$font_mono:italic:size=12
URxvt.bolditalicFont: xft:$font_mono for Powerline:bold:italic:size=12, xft:$font_mono:bold:italic:size=12
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintslight
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgba

URxvt.depth: 24
URxvt*foreground: $foreground
URxvt*background: [100]$background
*foreground: $foreground
*background: $background

! Black + DarkGrey
*color0: $black
*color8: $darkgrey
! DarkRed + Red
*color1: $darkred
*color9: $red
! DarkGreen + Green
*color2: $darkgreen
*color10: $green
! DarkYellow + Yellow
*color3: $darkyellow
*color11: $yellow
! DarkBlue + Blue
*color4: $darkblue
*color12: $blue
! DarkMagenta + Magenta
*color5: $darkmagenta
*color13: $magenta
! DarkCyan + Cyan
*color6: $darkcyan
*color14: $cyan
! LightGrey + White
*color7: $lightgrey
*color15: $white

rofi.lines: 3
rofi.font: $font $font_rofi_size
rofi.width: 17
rofi.padding: 10
rofi.location: 0
rofi.yoffset: -200
rofi.color-enabled: true
rofi.color-window: $background, $darkblue, $background
rofi.color-normal: $background, $darkgrey, $background, $darkblue, $white
rofi.color-urgent: $background, $darkgrey, $background, $darkblue, $white
rofi.color-active: $background, $darkgrey, $background, $darkblue, $white
rofi.terminal: urxvt
rofi.levenshtein-sort: false
