{ config, lib, pkgs, ... }:

let
  # to list all available vimPlugins execute the following command: "nix search nixpkgs#vimPlugins ."
  my-nix-plugins = with pkgs.vimPlugins; [
    nvim-web-devicons                  # adds really cool icons to nvim-tree
    lualine-nvim                      # powerline, visual input field at bottom in nvim
    catppuccin-nvim                   # colorscheme
    nvim-tree-lua                     # file browser (left)
    telescope-nvim                    # search engine
    telescope-fzf-native-nvim         # sorter for telescope, recommended
    nvim-treesitter
    nvim-treesitter-context
    nvim-treesitter-textobjects
    (nvim-treesitter.withPlugins ( p: [
      p.gdscript
      p.lua
      p.vim
      p.c
      p.vimdoc
    ]))
  ];

  my-vim-plugins = pkgs.vimUtils.buildVimPlugin {
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
        plugins = my-nix-plugins; # ++ [ my-vim-plugins ];
        extraPackages = with pkgs; [
          ripgrep
        ];
      };

      home.file.".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    }
  ];
}
