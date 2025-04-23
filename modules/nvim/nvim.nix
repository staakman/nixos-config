{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.neovim.defaultEditor = true;
}

