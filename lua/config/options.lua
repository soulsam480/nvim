vim.opt.number = true
vim.opt.signcolumn = "number"
vim.opt.list = true
vim.opt.cursorline = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep:|,foldclose:]]
vim.opt.smoothscroll = true
vim.opt.breakindent = true

vim.opt.listchars = {
	tab = "|..",
	trail = "·",
	space = ".",
	eol = "¬",
	extends = "»",
	precedes = "«",
	nbsp = "⣿",
}

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])

vim.api.nvim_set_option("clipboard", "")

vim.diagnostic.config({ virtual_text = false })
-- vim.lsp.set_log_level("INFO")
