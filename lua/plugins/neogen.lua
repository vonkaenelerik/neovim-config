return{
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require('neogen').setup({
			enabled = true,
			languages = {
				cs = {
					template = {
						annotation_convention = "xmldoc"
					}
				}
			},
			snippet_engine = "luasnip",
		})
	end,
	keys = {
		{
			"<leader>nf",
			function()
				require('neogen').generate()
			end,
			desc = "Generate documentation"
		}
	},
}

