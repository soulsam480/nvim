return {
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"justinhj/battery.nvim",
			"nvim-tree/nvim-web-devicons",
			"justinhj/battery.nvim",
		},
		config = function()
			require("battery").setup({
				update_rate_seconds = 30,
				show_status_when_no_battery = true,
				show_plugged_icon = true,
				show_unplugged_icon = true,
				battery_threshold = 25,
			})

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
}
