$env.config.history.max_size = 10000
$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.config.table.mode = 'light'
$env.path ++= ["~/.local/bin", "~/bin"]
$env.COLORTERM = "truecolor"

alias vim = hx
alias ls = ls -a

# PROMPT THEME
def create_left_prompt [] {
  let path = $env.PWD | str replace -r $"^($env.HOME)" "~"
  let path_segment = if (is-admin) {
    $"(ansi red_bold)($path)"
  } else {
    $"(ansi xterm_springgreen1)($path)"
  }

  let git_current_ref = (do { git rev-parse --abbrev-ref HEAD } | complete | get stdout | str trim)
  let git_segment = if ($git_current_ref != "") {
    $"(ansi reset) [(ansi yellow)($git_current_ref)(ansi reset)]" 
  }

  let prompt = ($"($path_segment)($git_segment)" | str trim)
  $prompt
}
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_INDICATOR = $" (ansi cyan)» "
$env.PROMPT_COMMAND_RIGHT = ""

