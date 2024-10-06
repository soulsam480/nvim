return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"vue",
				"css",
				"tsx",
				"html",
			},
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
