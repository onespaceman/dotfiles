{...}: {
  systemd.services.docky = {
    enable = true;
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    description = "Docker dashboard";
    serviceConfig = {
      ExecStart = "/docker/docky/docky";
      Type = "simple";
      WorkingDirectory = "/docker/docky";
      User = "spaceman";
    };
  };
}
