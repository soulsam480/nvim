vim.keymap.set({ "n", "v", "^V" }, "<leader>y", '"+y', { noremap = true, desc = "Copy to clipboard" })

vim.keymap.set({ "n", "v", "^V" }, "<leader>yy", '"+yy', { noremap = true, desc = "Copy line to clipboard" })

vim.keymap.set("n", "<C-c>", "<cmd>:bdelete<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>cc", "<cmd>%bd<CR>", { desc = "Close all open buffers" })

vim.keymap.set("n", "<C-u>", "15k", { noremap = true })

vim.keymap.set("n", "<C-d>", "15j", { noremap = true })
