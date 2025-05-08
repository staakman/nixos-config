return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							library = {
								vim.fn.expand("~/.config/nvim/lua/stubs/"), -- path to your stub
							},
						},
					},
				},
			},
		},
	},
}
