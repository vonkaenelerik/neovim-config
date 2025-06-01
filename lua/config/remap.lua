vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>pV', vim.cmd.Rex)

-- Insert escaping
vim.keymap.set('i', 'jj', '<Esc>')

-- Highlight when yanking (copying) text
--  `yap` to copy entire paragraph
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Moving visual selection
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Jumping page blocks whilst keeping cursor in middle
vim.keymap.set('n', '<C-D>', '<C-d>zz')
vim.keymap.set('n', '<C-U>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '10jzz')
vim.keymap.set('n', '<C-u>', '10kzz')

-- Searching keeps cursor in middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Yanking to system clipboard
vim.keymap.set('n', '<leader>y', '\"+y')       -- Yank to clipboard in normal mode
vim.keymap.set('v', '<leader>y', '\"+y')       -- Yank to clipboard in visual mode
vim.keymap.set('n', '<leader>yap', '\"+yap')   -- Yank a paragraph to clipboard in normal mode
vim.keymap.set('v', '<leader>yap', '\"+yap')   -- Yank a paragraph to clipboard in visual mode

-- Format code using LSP
vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format()
end)

-- Search and replace the word under cursor (case-insensitive)
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])  -- Global replacement
vim.keymap.set('n', '<leader>S', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])      -- Non-word-boundary replacement

-- Open LazyGit (Git TUI)
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>')

-- Paste over selection without overwriting the default register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Replace selection with user input
vim.api.nvim_set_keymap('v', '<leader>r', ':<C-u>lua ReplaceSelection()<CR>', { noremap = true, silent = false })

function ReplaceSelection()
  local old = vim.fn.input("Find: ")      -- Prompt user for text to find
  if old == "" then return end            -- Exit if empty input
  local new = vim.fn.input("Replace with: ")  -- Prompt user for replacement text
  vim.cmd("'<,'>s/" .. old .. "/" .. new .. "/g")  -- Perform substitution in selected range
end

-- LSP rename symbol
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function()
        vim.cmd(i .. "wincmd w")
    end, { noremap = true, silent = true })
end

-- Add python markdown chunk
vim.api.nvim_set_keymap('n', '<Leader>pc', 'o```{python}<CR>```<Esc>O', { noremap = true, silent = true })

-- Add R markdown chunk
vim.api.nvim_set_keymap('n', '<Leader>rc', 'o```{r}<CR>```<Esc>O', { noremap = true, silent = true })

-- Jump to next code chunk start
vim.api.nvim_set_keymap('n', ']]', '/^```{[^}]*}<CR>', { noremap = true, silent = true })

-- Jump to previous code chunk start
vim.api.nvim_set_keymap('n', '[[', '?^```{[^}]*}<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", { noremap = true, silent = true })
