{
  config,
  pkgs,
  ...
}: {
  age.secrets.restic.file = ../secrets/restic.age;

  environment.systemPackages = [pkgs.restic];

  services.restic.backups.backup = {
    initialize = true;
    repository = "/mnt/2/backup";
    passwordFile = config.age.secrets.restic.path;
    backupPrepareCommand = ''
      ${config.virtualisation.docker.package}/bin/docker exec koito-db pg_dump -U postgres -Fc koitodb > /docker/koito-backup.dump;
      ${config.virtualisation.docker.package}/bin/docker exec miniflux-db pg_dump -U miniflux -Fc minifluxdb > /docker/miniflux-backup.dump'';
    paths = [
      "/docker/"
      "/home/"
      "/mnt/3/"
    ];
    exclude = [
      "/home/.*"
      "/docker/koito/db"
      "/docker/miniflux"
    ];
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 12"
    ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
