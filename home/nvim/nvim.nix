{ pkgs, lib, ... }:

let
  plugins = with pkgs.vimPlugins; [
    LazyVim
    bufferline-nvim
    # cmp-buffer
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
    # nvim-cmp
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
    { name = "LuaSnip"; path = pkgs.vimPlugins.luasnip; }
    { name = "catppuccin"; path = pkgs.vimPlugins.catppuccin-nvim; }
    { name = "mini.ai"; path = pkgs.vimPlugins.mini-nvim; }
    { name = "mini.bufremove"; path = pkgs.vimPlugins.mini-nvim; }
    { name = "mini.comment"; path = pkgs.vimPlugins.mini-nvim; }
    { name = "mini.indentscope"; path = pkgs.vimPlugins.mini-nvim; }
    { name = "mini.pairs"; path = pkgs.vimPlugins.mini-nvim; }
    { name = "mini.surround"; path = pkgs.vimPlugins.mini-nvim; }
  ];

  mkEntryFromDrv = drv:
    if lib.isDerivation drv then
      { name = "${lib.getName drv}"; path = drv; }
    else
      drv;

  lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);

  parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
      c
      lua
    ])).dependencies;
  };
in {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      ripgrep
      nil
      nixpkgs-fmt
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig = ''
      require("lazy").setup({
        defaults = {
          lazy = true,
        },
        dev = {
          path = "${lazyPath}",
          patterns = { "" },
          fallback = true,
        },
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
          { "williamboman/mason-lspconfig.nvim", enabled = false },
          { "williamboman/mason.nvim", enabled = false },
          { import = "plugins" },
          { import = "plugins.lsp-nix" },
          { "nvim-treesitter/nvim-treesitter", opts = function(_, opts) opts.ensure_installed = {} end },
        },
      })
    '';
  };

  xdg.configFile."nvim/parser".source = "${parsers}/parser";
  xdg.configFile."nvim/lua".source = ./lua;
}
