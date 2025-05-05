{ config, lib, pkgs, ... }: {
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

    unzip                 # unzip files, used by nvim
    ffmpeg                # video lib, used by nvim
    imagemagick           # image lib, used by nvim
    lua-language-server   # lua, used by nvim to be able to read lua config files (needed for gdscript)

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
  
  /*
  # lazyVim
  home.file.".config/nvim".source = ./../modules/programs/editor/nvim;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;  # optional, useful for LSPs
    withPython3 = true; # optional
    withRuby = false;
    plugins = [ ];      # leave empty!
    extraConfig = ''''; # leave empty or add basic config
  };
  */
  
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        # LazyVim
        lua-language-server
        stylua
        # Telescope
        ripgrep
      ];

      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];

      extraLuaConfig =
        let
          plugins = with pkgs.vimPlugins; [
            # LazyVim
            LazyVim
            bufferline-nvim
            cmp-buffer
            cmp-nvim-lsp
            cmp-path
            cmp_luasnip
            conform-nvim
            dashboard-nvim
            dressing-nvim
            flash-nvim
            friendly-snippets
            gitsigns-nvim
            indent-blankline-nvim
            lualine-nvim
            neo-tree-nvim
            neoconf-nvim
            neodev-nvim
            noice-nvim
            nui-nvim
            nvim-cmp
            nvim-lint
            nvim-lspconfig
            nvim-notify
            nvim-spectre
            nvim-treesitter
            nvim-treesitter-context
            nvim-treesitter-textobjects
            nvim-ts-autotag
            nvim-ts-context-commentstring
            nvim-web-devicons
            persistence-nvim
            plenary-nvim
            telescope-fzf-native-nvim
            telescope-nvim
            todo-comments-nvim
            tokyonight-nvim
            trouble-nvim
            vim-illuminate
            vim-startuptime
            which-key-nvim
            { name = "LuaSnip"; path = luasnip; }
            { name = "catppuccin"; path = catppuccin-nvim; }
            { name = "mini.ai"; path = mini-nvim; }
            { name = "mini.bufremove"; path = mini-nvim; }
            { name = "mini.comment"; path = mini-nvim; }
            { name = "mini.indentscope"; path = mini-nvim; }
            { name = "mini.pairs"; path = mini-nvim; }
            { name = "mini.surround"; path = mini-nvim; }
          ];
          mkEntryFromDrv = drv:
            if lib.isDerivation drv then
              { name = "${lib.getName drv}"; path = drv; }
            else
              drv;
          lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
        in
        ''
          require("lazy").setup({
            defaults = {
              lazy = true,
            },
            dev = {
              -- reuse files from pkgs.vimPlugins.*
              path = "${lazyPath}",
              patterns = { "" },
              -- fallback to download
              fallback = true,
            },
            spec = {
              { "LazyVim/LazyVim", import = "lazyvim.plugins" },
              -- The following configs are needed for fixing lazyvim on nix
              -- force enable telescope-fzf-native.nvim
              { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
              -- disable mason.nvim, use programs.neovim.extraPackages
              { "williamboman/mason-lspconfig.nvim", enabled = false },
              { "williamboman/mason.nvim", enabled = false },
              -- import/override with your plugins
              { import = "plugins" },
              -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
              -- { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
	      { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.ensure_installed = {} end, },
	    },
          })
        '';
    };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
          c
          lua
        ])).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./../modules/programs/editor/nvim/lua;
  

  home.stateVersion = "24.11";
}
