{
  description = "Thierry's NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    
    system = "x86_64-linux";
    
    settings = {
      browser = "firefox";
      terminalFileManager = "yazi";
      terminal = "kitty";
      kbdLayout = "us";
      kbdVariant = "";
      wallpaper = "Train.jpg"; # see modules/themes/wallpapers
    };

    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/configuration.nix
          ./hosts/hardware-configuration.nix
          ./modules/desktop/hyprland
          ./modules/media/discord
          ./modules/media/mpv
          ./modules/media/obs-studio
          ./modules/media/spicetify
          ./modules/programs/browser/firefox
          ./modules/programs/cli/lazygit
          ./modules/programs/cli/starship
          ./modules/programs/cli/yazi
          # ./modules/programs/editor/nvim # < right here I include default.nix which I shared with you
          ./modules/programs/shell/bash
          ./modules/programs/terminal/kitty
          ./modules/programs/virtualization/docker/docker.nix

          {
            nixpkgs.overlays = [ 
              inputs.nur.overlay
            ]; 
          }

          {
            _module.args = {
              self = self;
              inputs = inputs; 
              browser = settings.browser;
              terminalFileManager = settings.terminalFileManager;
              terminal = settings.terminal;
              kbdVariant = settings.kbdVariant;
              kbdLayout = settings.kbdLayout;
              wallpaper = settings.wallpaper;
            };
          }

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            #home-manager.users.thierry = import ./home/thierry.nix;
            home-manager.users.thierry = { config, lib, pkgs, ... }: {
              # _module.args = { };

              imports = [
                ./home/thierry.nix
              ];
            };
          }
        ];
      };
    };
}
