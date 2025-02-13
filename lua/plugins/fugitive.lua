return {
    "tpope/vim-fugitive",
    config = function()
        -- git status
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        -- fugative buffer remaps/options
        local fugative_config = vim.api.nvim_create_augroup("fugative_config", {})
        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = fugative_config,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}
                -- pushes changes
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                -- pull changes
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git('pull')
                end, opts)

                -- git add, followed by user input
                vim.keymap.set("n", "<leader>a", ":Git add ", opts)

                -- git commit, followed by user input
                vim.keymap.set("n", "<leader>c", function()
                    local msg = vim.fn.input("Commit message: ")
                    if msg ~= "" then
                        vim.cmd("Git commit -m \"" .. msg .. "\"")
                    else
                        print("Aborted: No commit message provided.")
                    end
                end, opts)

                -- Starts a git push -u origin, allowing the user to input the branch name manually
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
            end,
        })


        -- accept left-side version
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")

        -- accept right-side version
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}
