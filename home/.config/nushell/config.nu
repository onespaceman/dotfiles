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
  mut prompt = if (is-admin) {
    (ansi red_bold)
  } else {
    (ansi xterm_springgreen1)
  }

  $prompt ++= ($env.PWD | str replace -r $"^($env.HOME)" "~")
  let git_status = (git status -bs --porcelain=2 | complete | get stdout | str trim)
  if ($git_status != "") {
    $prompt ++= $" (ansi reset)["
    $prompt ++= if ($git_status | str contains "\n?") {
      $"(ansi red_bold)"
    } else if ($git_status =~ '\n\d') {
      $"(ansi yellow_bold)"
    } else {
      $"(ansi green_bold)"
    }
    $prompt ++= $"($git_status | parse -r '.*branch.head (.*)' | get capture0.0)(ansi reset)]"
  }

  $prompt | str trim
}
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_INDICATOR = $" (ansi cyan)» "
$env.PROMPT_COMMAND_RIGHT = ""

