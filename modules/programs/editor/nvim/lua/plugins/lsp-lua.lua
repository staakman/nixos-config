return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          -- Tell LazyVim not to use Mason for lua_ls
          mason = false,
          -- Explicitly set the command to use the system binary
          cmd = { "lua-language-server" },
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
