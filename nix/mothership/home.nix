{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      duf
      ffmpeg
    ];
  };

  xdg.configFile."nushell/autoload/login.nu".text = ''
      duf --hide-fs devtmpfs,tmpfs,efivarfs
      journalctl -p err -b --output=with-unit | grep --line-buffered -v docker
    '';
}
