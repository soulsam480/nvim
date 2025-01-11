-- Copy to clipboard
vim.cmd([[
  nnoremap <leader>y "+y
  nnoremap <leader>yy "+yy
]])

vim.keymap.set("n", "<C-c>", "<cmd>:bdelete<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>cc", "<cmd>%bd<CR>", { desc = "Close all open buffers" })

vim.keymap.set("n", "<C-u>", "15k", { noremap = true })
vim.keymap.set("n", "<C-d>", "15j", { noremap = true })
