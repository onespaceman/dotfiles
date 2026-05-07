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
      ${config.virtualisation.docker.package}/bin/docker exec miniflux-db pg_dump -U miniflux -Fc minifluxdb > /docker/miniflux-backup.dump'';
    paths = [
      "/docker/"
      "/home/"
      "/mnt/3/"
    ];
    pruneOpts = [
      "--keep-hourly 4"
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 12"
    ];
    timerConfig = {
      OnCalendar = "*-*-* 0-23/6:00:00";
      Persistent = true;
    };
  };
}
