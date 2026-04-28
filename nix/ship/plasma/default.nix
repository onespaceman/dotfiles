{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    gwenview
    kate
    khelpcenter
    konsole
    plasma-browser-integration
  ];
}
