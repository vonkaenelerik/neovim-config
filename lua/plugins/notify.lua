return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			maximum_width = 10,
			timeout = 1000,
			background = "FloatShadow",
			stages = "fade_in_slide_out",
		})
		vim.notify = require("notify")
	end,
}
