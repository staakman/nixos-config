{ config, lib, pkgs, ... }: {

  imports = [
    # ./nvim/nvim.nix
  ];

  home.username = "thierry";
  home.homeDirectory = "/home/thierry";

  home.packages = with pkgs; [
    neofetch              # system info
    waybar                # top bar
    gcc                   # c compiler
    signal-desktop        # signal app
    home-manager          # manage home folder
    jq                    # json
    fd                    # finder for nvim
    vlc                   # video player

    nakama                # nakama game server
    docker                # docker engine
    docker-compose        # multi-docker engine

    openssl               # cryptographic library

    lua-language-server   # lua, used by nvim to be able to read lua config files (needed for gdscript)

    openfortivpn          # work - vpn
    terraform             # work - terraform
    qemu                  # work - virtualization
    kubectl               # work - kubectl
    teams-for-linux       # work - teams


    # inputs.nixvim.packages.${pkgs.system}.default

    (godot.overrideAttrs (oldAttrs: {
      dontStrip = false;
      dontInstallDebugSymbols = true;
      separateDebugInfo = false;
    }))
    
  ];

  programs.git = {
    enable = true;
    userName = "Thierry Staakman";
    userEmail = "thierry@example.com";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.keychain = {
    enable = true;
    keys = [ "id_ed25519" ];
  };

  programs.home-manager.enable = true;

  # used by Godot for project encryption
  home.sessionVariables = {
    SCRIPT_AES256_ENCRYPTION_KEY = "6943da0c0a5b0e80bd16832694dbbcf4155ccf83f936ea6299d97567e3f2d7ce";
  };
  
  xdg.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = "vlc.desktop";
    };
  };

  home.stateVersion = "24.11";
}
