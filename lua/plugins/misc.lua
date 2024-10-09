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
		"chriskempson/base16-vim",

		config = function()
			vim.opt.termguicolors = true
			vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
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
		"justinhj/battery.nvim",
		config = function()
			require("battery").setup({
				update_rate_seconds = 30,
				show_status_when_no_battery = true,
				show_plugged_icon = true,
				show_unplugged_icon = true,
				battery_threshold = 25,
			})
		end,
	},
	{

		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "justinhj/battery.nvim" },
		config = function()
			local nvimbattery = {
				function()
					return require("battery").get_status_line()
				end,
				color = { fg = vim.g.base16_gui05, bg = vim.g.base16_gui00 },
			}

			require("lualine").setup({
				options = { theme = "base16" },
				sections = {
					lualine_a = {
						"mode",
						{
							"datetime",
							style = "%I:%M:%S %p",
							icon = "🕒",
						},
					},
					lualine_x = { "filetype", nvimbattery },
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
