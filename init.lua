require("config.lazy")

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "number"
vim.opt.list = true

-- this is for experiment
-- vim.o.listchars = "tab:|..,trail:·,extends:»,precedes:«,nbsp:⣿"

vim.opt.listchars = {
	tab = "|..",
	trail = "·",
	eol = "¬",
}

vim.cmd([[tnoremap <Esc> <C-\><C-n>]])
