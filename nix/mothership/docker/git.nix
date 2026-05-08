{config, ...}: {
  age.secrets.gitserver.file = ../../secrets/gitserver.age;

  virtualisation.oci-containers.containers.git = {
    image = "castlemilk/git-http-backend:latest";
    hostname = "git";
    networks = ["pub"];
    ports = ["3999:3000"];
    volumes = [
      "/docker/git:/tmp/git"
    ];
    environmentFiles = [config.age.secrets.gitserver.path];
  };
}
