{
  config,
  pkgs,
  ...
}: {
  users.users.spaceman.extraGroups = ["docker"];

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings.dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  age.secrets.docker.file = ../../secrets/docker.age;

  systemd.services.docker-stack = {
    description = "Docker Compose Stack";
    after = ["network.target" "docker.service"];
    wants = ["docker.service"];

    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose --env-file ${config.age.secrets.docker.path} -f ${./compose.yml} up";
      ExecStop = "${pkgs.docker}/bin/docker compose -f ${./compose.yml} down";
      WorkingDirectory = "/docker";
      Restart = "always";
    };

    wantedBy = ["multi-user.target"];
  };
}
