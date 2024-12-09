-- Copy to clipboard
vim.cmd([[
  nnoremap <leader>y "+y
  nnoremap <leader>yy "+yy
]])

vim.keymap.set("n", "<leader>cc", "<cmd>:bdelete<CR>", { desc = "Close current buffer" })
