{ config, lib, pkgs, ... }:

let
  myVimPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "my-vim";
    src = ./nvim;
  };
in
{
  home-manager.sharedModules = [
    {
      programs.neovim = {
        enable = true;
	defaultEditor = true;
	viAlias = true;
	vimAlias = true;
        # plugins = [ myVimPlugin ];
        extraConfig = ''
          lua require('config')
        '';
      };

      home.file.".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    }
  ];
}
