return {
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"chriskempson/base16-vim",
		config = function()
			vim.opt.termguicolors = true
			vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local dash = require("alpha.themes.theta")

			dash.file_icons.provider = "devicons"

			require("alpha").setup(dash.config)
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				enabled = true,
			})
		end,
	},
}
