{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kde-pim.enable = false;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    gwenview
    kate
    khelpcenter
    kmail
    konsole
    plasma-browser-integration
  ];
}
