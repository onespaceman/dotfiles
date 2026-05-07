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

  let git_status = (git status -bs | complete | get stdout | str trim | lines)
  if (($git_status | length) > 0) {
    $prompt ++= $"(ansi reset)["

    let parsed = ($git_status | parse -r '^(?:([MADR])|.)([MADR?])?')
    $prompt ++= if (($parsed.capture1 | str join | str length) > 0) { (ansi red) # unstaged changes
    } else if (($parsed.capture0 | str join | str length) > 0) { (ansi yellow)   # staged chages
    } else { (ansi green) }                                                      # clear

    $prompt ++= ($git_status | parse -r '^## (.*)(?:\.\.\.|$)' | get capture0.0)
    if ("D" in $parsed.capture1) { $prompt ++= $"(ansi red)⨯" } else if ("D" in $parsed.capture0) { $prompt ++= $"(ansi yellow)⨯" } # deleted
    if ("A" in $parsed.capture0) { $prompt ++= $"(ansi yellow)+" } # added
    if ("M" in $parsed.capture1) { $prompt ++= $"(ansi yellow)!" } # modified
    if ('?' in $parsed.capture1) { $prompt ++= $"(ansi purple)?" } # untracked files
    $prompt ++= $"(ansi reset)] "
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
