# ~/.zshrc

#############
### zplug ###
#############

source "$HOME/.zplug/zplug" || { curl -fLo ~/.zplug/zplug --create-dirs git.io/zplug && source ~/.zplug/zplug }

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "onespaceman/af3ef877e4a0e8c8a762", from:gist, of:minimal-theme
zplug "onespaceman/597dd7260fa5f2ae8258", from:gist, of:zsh-title
zplug "onespaceman/3b19864627e3cae642e4", from:gist, of:utilities
zplug "onespaceman/b250edb6c891fa5c5e45", from:gist, of:zsh-completion

zplug check || zplug install && zplug load

###########
# history #
###########

HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

# substring history
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down

###############
# environment #
###############

export set PATH=$PATH:$HOME/bin
source $HOME/.aliases

# default editor
export EDITOR=nvim
export VISUAL=nvim

# options
setopt CORRECT
setopt EXTENDED_GLOB #allow special characters without quotes


