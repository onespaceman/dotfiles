## dotfiles

![screenshot of ncmpcpp](scrots/music.png)
![screenshot of vim and terminal](scrots/vim.png)

### theme
* **colors** _custom_
* **fonts** _Roboto_
* **wallpaper** *[from pixabay](https://pixabay.com/en/mountain-clouds-landscape-nature-983914/)*
* **gtk theme** *FlatStudioDark*
* **icons** *Flattr Dark*

### software
* **arch** *gnu/linux distro*
* **i3-gaps** *window manager*
* **lemonbar-xft** *status bar*
* **rxvt-unicode-24bit** *terminal emulator* with full color support
* **zsh** *shell*
  * **prezto** *zsh config framework*
* **rofi** *launcher*
* **thunar** *file manager*
* **gnu stow** *dotfiles/symlink manager*

#
* **google chrome** *browser*
  * **humble new tab page** *start page*
  * **modern flat** *theme*

#
* **mpd** *music daemon*
  * **ncmpcpp** *mpd frontend*
  * **GMusicProxy** *google play music for mpd*
  * **gmpplay** *helper for GMusicProxy*

#
* **vim** *text editor*
  * **vim-plug** *plugin manager*
  * **vim-airline** *status line*
  * **syntastic** *linter*
  * **supertab** *tab completion*
  * **gruvbox** *theme* used as base with customized colors
  * **vim-commentary** *comment out stuff*
  * **colorizer** *highlight colors*

### scripts
* **bootstrap** symlinks this repository into the appropriate locations using gnu stow. Also modifies certain files for use on OSX
* **ricemyride** generates configs for Xresources, vim, i3config, etc.
* **music** opens ncmpcpp and ncmpcpp visualizer in dedicated workspace
