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

vim.diagnostic.config({ virtual_text = false, underline = true, signs = true })
-- vim.lsp.set_log_level("INFO")
--
vim.g.lazyvim_blink_main = true

vim.opt.guicursor = {
	"n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
	"r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100",
}

vim.opt.showmode = false
