require("config.lazy")

vim.cmd([[colorscheme tokyonight-night]])

-- formatting
vim.keymap.set("n", "<leader>ii", vim.lsp.buf.format, {})
