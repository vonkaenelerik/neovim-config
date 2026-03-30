return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"L3MON4D3/LuaSnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

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
				"basedpyright",
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

		-- Fallback: set up servers available on PATH but not installed via Mason
		local mason_registry = require("mason-registry")
		local fallback_servers = {
			{ mason_name = "basedpyright", lsp_name = "basedpyright" },
			{ mason_name = "ruff",         lsp_name = "ruff" },
		}
		for _, server in ipairs(fallback_servers) do
			if not mason_registry.is_installed(server.mason_name) then
				if vim.fn.executable(server.lsp_name) == 1 then
					require("lspconfig")[server.lsp_name].setup {
						capabilities = capabilities,
					}
				end
			end
		end

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

	end
}
