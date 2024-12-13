vim.opt.number = true
vim.opt.signcolumn = "number"
vim.opt.list = true
vim.opt.cursorline = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:|,foldclose:]]
vim.opt.smoothscroll = true
vim.opt.breakindent = true

-- this is for experiment
-- vim.o.listchars = "tab:|..,trail:·,extends:»,precedes:«,nbsp:⣿"

vim.opt.listchars = {
	tab = "|..",
	trail = "·",
	eol = "¬",
}

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])

vim.api.nvim_set_option("clipboard", "")

vim.diagnostic.config({ virtual_text = false })
-- vim.lsp.set_log_level("INFO")
