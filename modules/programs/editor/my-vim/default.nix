{ config, lib, pkgs, ... }:

let
  # to list all available vimPlugins execute the following command: "nix search nixpkgs#vimPlugins ."
  my-nix-plugins = with pkgs.vimPlugins; [
    
    # buffer-line                     # Adds a tab-like buffer line at the top of the window with support for icons and LSP diagnostics

    # dashboard
    # dashboard-nvim                    # adds a nice looking dashboard when you open nvim
    alpha-nvim

    # git
    lazygit-nvim
    # gitblame

    # other
    vim-illuminate                    # Highlight same words

    plenary-nvim                      # dependency for todo-comments-nvim
    todo-comments-nvim                # Highlights and lists TODO, FIX, HACK

    # ident
    indent-blankline-nvim-lua         # colorize and visualize identation

    # INFO

    # input line
    noice-nvim

    # error handling
    nvim-notify

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
    
    # status line
    lualine-nvim                      # powerline, visual input field at bottom in nvim
    
    # colorscheme
    catppuccin-nvim
    tokyonight-nvim                   
    
    # file (search) browser
    telescope-nvim                    # search engine
    telescope-fzf-native-nvim         # sorter for telescope, recommended
    telescope-ui-select-nvim          # sets vim.ui.select to telescope

    # hotkey window helper
    which-key-nvim
    mini-nvim                         # icons

    # lexicon analyzer
    nvim-treesitter
    # nvim-treesitter-context
    nvim-treesitter-textobjects
    (nvim-treesitter.withPlugins ( p: [
      p.gdscript
      p.lua
      p.vim
      p.c
      p.vimdoc
      p.bash
      p.regex
      p.nix
      p.yaml
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
          lazygit
        ];
      };

      home.file.".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    }
  ];
}
