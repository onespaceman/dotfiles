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
  mut prompt = (ansi reset)

  if ("SSH_CLIENT" in $env) {
    $prompt ++= $"(ansi blue)($env.USER)@(sys host | get hostname)(ansi reset) "
  }

  $prompt ++= $"($env.PWD | str replace -r $"^($env.HOME)" "~") "

  let git_status = (git status -bs --porcelain=2 | complete | get stdout | str trim | lines)
  if (($git_status | length) > 0) {
    $prompt ++= $"(ansi reset)["
    $prompt ++= if (($git_status | parse -r '^\?' | length) > 0) {   # untracked files
      (ansi red)
    } else if (($git_status| parse -r '^\d .[ADMN]' | length) > 0 ) { # unstaged changes
      (ansi purple)
    } else if (($git_status| parse -r '^\d [ADMN]' | length) > 0 ) {   # staged changes
      (ansi yellow)
    } else {                                                         # clear
      (ansi green)
    }
    $prompt ++= $"($git_status | parse -r '^# branch\.head (.*)' | get capture0.0)(ansi reset)] "
  }

  $prompt
}

def create_indicator [] {
  if (is-admin) {
    $"(ansi red_bold)# "
  } else {
    $"(ansi cyan)» "
  }
}

$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_INDICATOR = { create_indicator }
$env.PROMPT_COMMAND_RIGHT = ""
