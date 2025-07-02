return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    -- Enable search integration
    search = {
      -- Enable flash when using / or ?
      enabled = true,
      -- Highlight matches
      highlight = { backdrop = false },
      -- Jump to first match automatically
      jump = { autojump = true },
    },
    -- Configure modes where flash is active
    modes = {
      -- Enable in search mode
      search = {
        enabled = true,
      },
      -- Enable in char mode (f, F, t, T)
      char = {
        enabled = true,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
