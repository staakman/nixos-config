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
  };

  outputs = { self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/nixos.nix
          ./hosts/hardware-configuration.nix
          #./modules/nvim/nvim.nix
          ./modules/desktop/hyprland
          ./modules/media/discord
          ./modules/media/mpv
          ./modules/media/obs-studio
          ./modules/media/spicetify
          ./modules/programs/browser/firefox
          ./modules/programs/cli/lazygit
          ./modules/programs/cli/starship
          ./modules/programs/editor/nvim
          ./modules/programs/shell/bash
          ./modules/programs/shell/zsh
          ./modules/programs/terminal/kitty

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.thierry = import ./home/thierry.nix;
          }
        ];
      };
    };
}
