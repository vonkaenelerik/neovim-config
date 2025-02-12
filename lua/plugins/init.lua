return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		ops = {
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"gdscript",
				"help",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"r",
				"regex",
				"toml",
				"vim",
				"vimdoc",
				"yaml",
			}
		}
	},
	{ "mbbill/undotree" },
	{ "tpope/vim-fugitive" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/nvim-cmp" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
}
