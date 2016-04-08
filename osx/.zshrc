# ~/.zshrc

#############
## plugins ##
#############

for config (${XDG_CONFIG_HOME:-$HOME/.config}/zsh/*.zsh) source $config

###############
# environment #
###############

export set PATH=$PATH:$HOME/bin

# default editor
export EDITOR=nvim
export VISUAL=nvim

# options
setopt CORRECT
setopt EXTENDED_GLOB #allow special characters without quotes
setopt AUTO_CD #change to a directory without typing cd.


