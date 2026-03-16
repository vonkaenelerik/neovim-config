vim.g.mapleader = " "

-- Write/Quit shortcuts
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>W", vim.cmd.W)
vim.keymap.set("n", "<leader>q", vim.cmd.q)
vim.keymap.set("n", "<leader>Q", vim.cmd.Q)

-- Window navigation
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

-- -- Escape
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
-- -- Relative escape
-- vim.keymap.set('n', '<leader>pV', vim.cmd.Rex)

-- Oil equivalents
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open current directory" })
vim.keymap.set("n", "<leader>pV", "<CMD>Oil .<CR>", { desc = "Open current directory" })

-- Insert escaping
vim.keymap.set("i", "jj", "<Esc>")

-- Moving visual selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor position while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Jumping page blocks whilst keeping cursor in middle
vim.keymap.set("n", "<C-D>", "<C-d>zz")
vim.keymap.set("n", "<C-U>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "10jzz")
vim.keymap.set("n", "<C-u>", "10kzz")

-- Prevents cursor from jumping when auto formating paragraph
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Searching keeps cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yanking to system clipboard. Works with motions
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Format code using LSP
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)

-- Search and replace the word under cursor (case-insensitive)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Global replacement in file
vim.keymap.set("n", "<leader>S", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Non-word-boundary replacement

-- Open LazyGit (Git TUI)
vim.keymap.set("n", "<leader>g", ":LazyGit<CR>")

-- Paste over selection without overwriting the default register
vim.keymap.set("x", "<leader>p", '"_dP')

-- Deletes text and sends to the shadow realm
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Quickfix/location list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz") -- Navigate to next item in quickfix list and center
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz") -- Navigate to previous item in quickfix list and center
vim.keymap.set("n", "<C-K>", "<cmd>lnext<CR>zz") -- Navigate to next item in location list and center
vim.keymap.set("n", "<C-J>", "<cmd>lprev<CR>zz") -- Navigate to previous item in location list and center

-- Replace selection with user input
vim.api.nvim_set_keymap("v", "<leader>r", ":<C-u>lua ReplaceSelection()<CR>", { noremap = true, silent = false })

function ReplaceSelection()
	local old = vim.fn.input("Find: ") -- Prompt user for text to find
	if old == "" then
		return
	end -- Exit if empty input
	local new = vim.fn.input("Replace with: ") -- Prompt user for replacement text
	vim.cmd("'<,'>s/" .. old .. "/" .. new .. "/g") -- Perform substitution in selected range
end

-- LSP rename symbol
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		vim.cmd(i .. "wincmd w")
	end, { noremap = true, silent = true })
end

-- Add python markdown chunk
vim.api.nvim_set_keymap("n", "<Leader>pc", "o```{python}<CR>```<Esc>O", { noremap = true, silent = true })

-- Add R markdown chunk
vim.api.nvim_set_keymap("n", "<Leader>rc", "o```{r}<CR>```<Esc>O", { noremap = true, silent = true })

-- Jump to next code chunk start
-- vim.api.nvim_set_keymap('n', ']]', '/^```{[^}]*}<CR>', { noremap = true, silent = true })

-- Jump to previous code chunk start
-- vim.api.nvim_set_keymap('n', '[[', '?^```{[^}]*}<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>fr",
	"<cmd>lua require('telescope.builtin').lsp_references()<CR>",
	{ noremap = true, silent = true }
)
