return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local ls = require("luasnip")
			ls.filetype_extend("javascript", { "jsdoc" })

			-- Jump with Tab/Shift-Tab
			vim.keymap.set({"i", "s"}, "<Tab>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, {silent = true})

			vim.keymap.set({"i", "s"}, "<S-Tab>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, {silent = true})

			-- Optional: Change choice (for choice nodes)
			vim.keymap.set({"i", "s"}, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, {silent = true})
		end,
	}
}

