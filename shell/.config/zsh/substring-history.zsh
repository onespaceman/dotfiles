# zsh substring history

if [ "$(uname)" = "Linux" ]; then
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    
    # keybindings
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

elif [ "$(uname)" = "Darwin" ]; then
    source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

    # keybindings
    bindkey "$terminfo[cuu1]" history-substring-search-up
    bindkey "$terminfo[cud1]" history-substring-search-down
fi
