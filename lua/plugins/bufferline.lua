return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						highlight = "Directory",
						separator = false,
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>t", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })


		vim.keymap.set("n", "<leader>ty", ":BufferClose<CR>", { noremap = true, silent = true })
	end,
}
