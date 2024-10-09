return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.opt.termguicolors = true
			vim.opt.background = "dark"
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_ui_contrast = "high"

			-- vim.g.background = "dark"
			vim.cmd([[colorscheme gruvbox-material]])
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
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
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({
				indent = { char = "|" },
				whitespace = {
					remove_blankline_trail = false,
				},
			})
		end,
	},
	{

		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "gruvbox-material" },
				sections = {
					lualine_a = {
						{
							"datetime",
							style = "%d-%m-%Y %I:%M:%S %p",
							icon = "🕒",
						},
					},
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				enabled = true,
			})
		end,
	},
}
