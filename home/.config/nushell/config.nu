$env.config.history.max_size = 10000
$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.config.table.mode = 'light'
$env.path ++= ["~/.local/bin", "~/bin"]
$env.COLORTERM = "truecolor"

alias vim = hx
alias ls = ls -a
alias gs = git status

# PROMPT THEME
def create_left_prompt [] {
  mut p = (ansi reset) # the prompt string

  if ("SSH_CLIENT" in $env) {
    $p ++= $"(ansi blue)($env.USER)@(sys host | get hostname)(ansi reset) "
  }

  $p ++= $"($env.PWD | str replace -r $"^($env.HOME)" "~")"

  try { # in case gstat is not installed
    let g = (gstat)
    if ($g.repo_name != "no_repository") {
      $p ++= $"(ansi reset)["
      
      let staged = ($g.idx_added_staged + $g.idx_modified_staged + $g.idx_deleted_staged + $g.idx_renamed + $g.idx_type_changed)
      let unstaged = ($g.wt_untracked + $g.wt_modified + $g.wt_deleted + $g.wt_type_changed + $g.wt_renamed)
      if ($staged > 0 and $unstaged > 0) { $p ++= (ansi purple) # both
      } else if ($staged > 0) { (ansi yellow) #staged changes
      } else if ($unstaged > 0) { (ansi red)
      } else { (ansi green) } # clear
      $p ++= $g.repo_name

      $p ++= if ($g.wt_deleted > 0) { $"(ansi red)⨯"} else if ($g.idx_deleted_staged > 0) { $"(ansi yellow)⨯" } else { "" } # deleted
      $p ++= if ($g.wt_modified + $g.wt_type_changed + $g.wt_renamed > 0) { $"(ansi red)❉"
      } else if ($g.idx_modified_staged + $g.idx_type_changed + $g.idx_renamed > 0) { $"(ansi yellow)❉" } else { "" } # modified
      $p ++= if ($g.idx_added_staged > 0) { $"(ansi yellow)+" } else { "" } # added
      $p ++= if ($g.wt_untracked > 0) { $"(ansi yellow)?" } else { "" } # untracked
      $p ++= $"(ansi reset)]"
    }
  }
  $p
}

$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_INDICATOR = { if (is-admin) { $" (ansi red_bold)# " } else { $" (ansi cyan)» " } }
$env.PROMPT_COMMAND_RIGHT = ""
