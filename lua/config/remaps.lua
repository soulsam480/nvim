-- Copy to clipboard
vim.cmd([[
  nnoremap <silent> <leader>y "+y
  nnoremap <silent> <leader>yy "+yy
]])

vim.keymap.set("n", "<leader>cc", "<cmd>:bdelete<CR>", { desc = "Close current buffer" })
