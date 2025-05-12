{ config, lib, pkgs, ... }:

let
  # to list all available vimPlugins execute the following command: "nix search nixpkgs#vimPlugins ."
  my-nix-plugins = with pkgs.vimPlugins; [
    
    # buffer-line                     # Adds a tab-like buffer line at the top of the window with support for icons and LSP diagnostics

    # autocompletion
    nvim-cmp                          # Autocompletion engine for Neovim
    cmp-nvim-lsp                      # Adds LSP (Language Server Protocol) support to nvim-cmp, enabling intelligent code suggestions
    cmp-path                          # Enables path/file autocompletion in nvim-cmp
    cmp-buffer 
    cmp-path 
    cmp_luasnip
    luasnip
    friendly-snippets

    # language Server
    nvim-lspconfig
    
    # file browser
    nvim-web-devicons                 # adds really cool icons to nvim-tree
    nvim-tree-lua                     # file browser (left)
    
    # lualine
    lualine-nvim                      # powerline, visual input field at bottom in nvim
    
    # colorscheme
    catppuccin-nvim                   # colorscheme
    
    # file (search) browser
    telescope-nvim                    # search engine
    telescope-fzf-native-nvim         # sorter for telescope, recommended

    # hotkey window helper
    which-key-nvim
    mini-nvim                         # icons

    # lexicon analyzer
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
