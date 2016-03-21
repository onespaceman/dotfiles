# set XDG dirs
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"

[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="$HOME/.local/share"

[[ -z "$GTK2_RC_FILES" ]] && export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

