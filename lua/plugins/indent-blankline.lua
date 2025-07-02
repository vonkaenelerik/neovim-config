return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		vim.api.nvim_set_hl(0, "IblScope", { fg = vim.api.nvim_get_hl(0, {name = "IblScope"}).fg })

		require("ibl").setup {
			indent = {
				-- char = "▏",
				char = "┊",
				-- char = "·",
			},
			scope = {
				show_start = false,
				show_end = false,
				enabled = true,
			},
		}
	end
}
