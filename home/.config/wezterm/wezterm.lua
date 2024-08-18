local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  local wsl_domains = wezterm.default_wsl_domains()

  for idx, dom in ipairs(wsl_domains) do
    if idx == 1 then
      config.default_domain = dom.name
    end
    table.insert(launch_menu, {
      label = 'New Tab: ' .. dom.name,
      domain = { DomainName = dom.name },
      cwd = '~'
    })
  end

  table.insert(launch_menu, {
    label = 'New Tab: PowerShell',
    domain = { DomainName = "local" },
    args = { 'powershell.exe', '-NoLogo' },
  })

end
config.launch_menu = launch_menu

config.window_close_confirmation = 'NeverPrompt'
config.skip_close_confirmation_for_processes_named = { }
config.keys = {
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  {
    key = 't',
    mods = 'CTRL',
    action = wezterm.action.SpawnTab 'DefaultDomain',
  },
  {
    key = 'v',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

config.color_scheme = 'Catppuccin Mocha (Gogh)'
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
  font = wezterm.font { family = 'Iosevka Term', weight = 'Regular' },
  font_size = 12.0,
}
config.font = wezterm.font 'Iosevka Term'
config.font_size = 11.0
config.initial_cols = 120
config.initial_rows = 35

return config