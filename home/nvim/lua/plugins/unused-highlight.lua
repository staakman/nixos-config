return {
	{
		"nvim-lspconfig",
		config = function()
			-- Semantic tokens
			vim.api.nvim_set_hl(0, "@lsp.typemod.variable.unused", { fg = "#32CD32", italic = true })
			vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.unused", { fg = "#32CD32", italic = true })
			vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.declaration.unused", { fg = "#32CD32", italic = true })

			-- Diagnostic group used for graying out unused code
			vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#32CD32", italic = true })
		end,
	},
}
