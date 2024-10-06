return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				diagnostics = "nvim_lsp",
				style_preset = bufferline.style_preset.minimal,
			},
		})

		vim.keymap.set("n", "<C-Tab>", ":BufferLineCycleNext", {})
	end,
}
