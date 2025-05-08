{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  
  programs.virt-manager.enable = true;
  
  users.users.thierry.extraGroups = [ "libvirtd" "kvm" ];
}
