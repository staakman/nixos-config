{ config, lib, pkgs, ... }:

{
  # Enable the Docker service
  services.docker.enable = true;

  # (Optional) Allow the default user to access the Docker daemon
  users.users.thierry.extraGroups = [ "docker" ];
}
