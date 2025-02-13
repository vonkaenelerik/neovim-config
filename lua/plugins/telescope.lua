return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')

        -- file search
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

        -- git file search
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        -- greps for word under the cursor
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        -- greps for the full text under the cursor, including special characters
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        -- grep search
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        -- searches neovims help documentation
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
