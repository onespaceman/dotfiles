function +vi-git_status {
  # Check for untracked files or updated submodules since vcs_info does not.
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    hook_com[unstaged]='%F{red}'
  fi
}

function prompt_minimal_precmd {
  vcs_info
}

setopt prompt_subst

function prompt_minimal_setup {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  # Load required functions.
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  # Add hook for calling vcs_info before each command.
  add-zsh-hook precmd prompt_minimal_precmd

  # Set vcs_info parameters.
  zstyle ':vcs_info:*' enable bzr git hg svn
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' stagedstr '%F{green}'
  zstyle ':vcs_info:*' unstagedstr '%F{yellow}'
  zstyle ':vcs_info:*' formats ' [%c%u%b%f]'
  zstyle ':vcs_info:*' actionformats " %c%u[%b|%F{cyan}%a%f]%f"
  zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b|%F{cyan}%r%f'
  zstyle ':vcs_info:git*+set-message:*' hooks git_status

  # Define prompts.
  PROMPT='%2~${vcs_info_msg_0_} %F{blue}» %f'
  RPROMPT=''
}

prompt_minimal_setup "$@"
