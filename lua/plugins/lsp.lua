return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
			}
		})
		-- local cmp = require('cmp')
		-- local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities()
			-- cmp_lsp.default_capabilities()
		)


		require('fidget').setup({})
		require('mason').setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:crashdummyy/mason-registry",
			},
		})
		require('mason-lspconfig').setup({
			ensure_installed = {
				"clangd",
				"lua_ls",
				"ruff",
				"bashls",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						capabilities = capabilities
					}
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup {
						capabilities = capabilities,
						settings = {
							lua = {
								format = {
									enable = true,
									-- put format options here
									-- note: the value should be string!!
									defaultconfig = {
										indent_style = "space",
										indent_size = "2",
									}
								}
							}
						}
					}
				end,
			}
		})

		-- local cmp_select = { behavior = cmp.selectbehavior.select }
		-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')

		-- cmp.setup({
		-- 	snippet = {
		-- 		expand = function(args)
		-- 			require('luasnip').lsp_expand(args.body) -- for `luasnip` users.
		-- 		end,
		-- 	},
		-- 	mapping = cmp.mapping.preset.insert({
		-- 		['<c-p>'] = cmp.mapping.select_prev_item(cmp_select),
		-- 		['<c-n>'] = cmp.mapping.select_next_item(cmp_select),
		-- 		['<c-y>'] = cmp.mapping.confirm({ select = true }),
		-- 		["<c-space>"] = cmp.mapping.complete(),
		-- 		['<cr>'] = cmp.mapping.confirm({ select = true }),
		-- 	}),
		-- 	sources = cmp.config.sources({
		-- 		{ name = 'nvim_lsp' },
		-- 		{ name = 'luasnip' }, -- for luasnip users.
		-- 	}, {
		-- 			{ name = 'buffer' },
		-- 		})
		-- })
		--
		-- cmp.event:on(
		-- 	'confirm_done',
		-- 	cmp_autopairs.on_confirm_done()
		-- )
		--
		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		vim.api.nvim_create_autocmd("bufwritepre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

	end
}
