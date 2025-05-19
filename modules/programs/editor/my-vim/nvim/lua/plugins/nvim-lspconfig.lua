local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lua
require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
})

-- nix
require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
        },
      },
    },
  },
})

-- gdscript
require("lspconfig").gdscript.setup({
  capabilities = capabilities,
})

require("lspconfig").gdshader_lsp.setup({
  capabilities = capabilities,
})

-- vim
require("lspconfig").vimls.setup({
  capabilities = capabilities,
})

-- bash
require("lspconfig").bashls.setup({
  capabilities = capabilities,
})
