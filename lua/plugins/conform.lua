return {
	'stevearc/conform.nvim',
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				r = { "air" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
				sql = { "sqruff" },
				cs = { "csharpier" },
			},
			-- format_on_save = {
			-- 	-- These options will be passed to conform.format()
			-- 	timeout_ms = 500,
			-- 	lsp_format = "fallback",
			-- },
		})
	end
}

