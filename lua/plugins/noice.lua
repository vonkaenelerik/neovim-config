return{
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- LSP progress handling fix
				progress = {
					enabled = false,  -- Disable to avoid token concatenation error
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	}
}
