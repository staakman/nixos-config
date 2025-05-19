{
  description = "Thierry's NixOS with integrated Home Manager config";

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

    catppuccin.url = "github:catppuccin/nix";

  };


  outputs = inputs@{ self, nixpkgs, home-manager, ... }: let
    
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    
    settings = {
      browser = "firefox";
      terminalFileManager = "yazi";
      terminal = "kitty";
      kbdLayout = "us";
      kbdVariant = "";
      wallpaper = "abstract/wallpaper_4.jpg"; # see modules/themes/wallpapers
    };

    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.nil pkgs.nixpkgs-fmt ];
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/configuration.nix
          ./hosts/hardware-configuration.nix
          ./modules/themes/catppuccin
          ./modules/desktop/hyprland
          ./modules/drivers/webcam
          ./modules/media/discord
          ./modules/media/mpv
          ./modules/media/obs-studio
          ./modules/media/spicetify
          ./modules/programs/browser/firefox
          ./modules/programs/cli/direnv
          ./modules/programs/cli/lazygit
          ./modules/programs/cli/starship
          ./modules/programs/cli/yazi
          ./modules/programs/editor/my-vim
          ./modules/programs/shell/bash
          ./modules/programs/shell/zsh
          ./modules/programs/terminal/kitty 
          ./modules/programs/virtualization/docker
          ./modules/programs/virtualization/virt-manager
          
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
            home-manager.users.thierry = { config, lib, pkgs, ... }: {
              # _module.args = { };
              imports = [
                inputs.catppuccin.homeModules.catppuccin
                ./home/thierry.nix
              ];
            };
          }
        ];
      };
    };
}
