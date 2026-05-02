{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      duf
      ffmpeg
    ];
  };

  xdg.configFile."nushell/autoload/login.nu".text = ''
    duf --hide-fs devtmpfs,tmpfs,efivarfs
  '';
}
