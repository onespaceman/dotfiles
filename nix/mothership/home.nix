{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      duf
      ffmpeg
    ];
  };

  xdg.configFile."nushell/autoload/login.nu".text = ''
    duf --hide-fs devtmpfs,tmpfs,efivarfs
    journalctl -p err -b -r --output=with-unit | grep --line-buffered -Ev "docker|samba"
  '';
}
