# ~/.zshrc

#############
### zplug ###
#############

source "$HOME/.zplug/zplug" || { curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug && source ~/.zplug/zplug }

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "onespaceman/af3ef877e4a0e8c8a762", from:gist, of:minimal-theme
zplug "onespaceman/597dd7260fa5f2ae8258", from:gist, of:zsh-title
zplug "onespaceman/818caf459418bc389774", from:gist, of:zsh-substring-history
zplug "onespaceman/3b19864627e3cae642e4", from:gist, of:utilities
zplug "onespaceman/b250edb6c891fa5c5e45", from:gist, of:zsh-completion
zplug "onespaceman/01725722b00c98bce5eb", from:gist, of:zsh-history

zplug check || zplug install && zplug load

###############
# environment #
###############

export set PATH=$PATH:$HOME/bin
source $HOME/.aliases

#default editor
export EDITOR=“nvim”
export VISUAL="nvim"

#options
setopt CORRECT
setopt EXTENDED_GLOB #allow special characters without quotes

#virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
source "/usr/bin/virtualenvwrapper.sh"

