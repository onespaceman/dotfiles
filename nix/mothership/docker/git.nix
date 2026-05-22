{...}: {
  virtualisation.oci-containers.containers.git = {
    image = "codeberg.org/forgejo/forgejo:15-rootless";
    hostname = "git";
    autoStart = true;
    networks = ["pub"];
    ports = ["3999:3000" "2222:2222"];
    user = "1000:100";
    volumes = [
      "/docker/forgejo:/var/lib/gitea"
      "/etc/localtime:/etc/localtime:ro"
    ];
    environment = {
      USER_UID = "1000";
      USER_GID = "100";
      FORGEJO__server__LANDING_PAGE = "/explore/repos";
      FORGEJO__service__DISABLE_REGISTRATION = "true";
      FORGEJO__service__SHOW_MILESTONES_DASHBOARD_PAGE = "false";
      "FORGEJO__service.explore__DISABLE_USERS_PAGE" = "true";
      "FORGEJO__service.explore__DISABLE_ORGANIZATIONS_PAGE" = "true";
      FORGEJO__repository__DEFAULT_REPO_UNITS = "repo.code,repo.releases";
      FORGEJO__repository__DEFAULT_MIRROR_UNITS = "repo.code,repo.releases";
      FORGEJO__repository__ENABLE_PUSH_CREATE_USER = "true";
      FORGEJO__ui__SHOW_USER_EMAIL = "false";
    };
  };
}
