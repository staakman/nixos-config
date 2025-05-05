return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false, -- disable mason install
          cmd = { "lua-language-server" }, -- use system binary
        },
      },
    },
  },
}
