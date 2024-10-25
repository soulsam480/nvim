--- Copy to clipboard
vim.cmd([[
  vnoremap <silent> <leader>y "+y
  nnoremap <silent> <leader>Y "+yg_
  nnoremap <silent> <leader>y "+y
  nnoremap <silent> <leader>yy "+yy
]])

-- Paste from clipboard
vim.cmd([[
  nnoremap <silent> <leader>p "+p
  nnoremap <silent> <leader>P "+P
  vnoremap <silent> <leader>p "+p
  vnoremap <silent> <leader>P "+P
]])
