return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "<leader>gpc", gitsigns.preview_hunk)
				end,
			})
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
}
