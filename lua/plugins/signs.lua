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
				color = { fg = vim.g.base16_gui0B, bg = vim.g.base16_gui01 },
			}

			require("lualine").setup({
				options = {
					theme = "base16",
				},
				sections = {
					lualine_a = {
						"mode",
						{
							"datetime",
							style = "%I:%M:%S %p",
							icon = "🕒",
						},
					},
					lualine_c = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 3,
							shorting_target = 40, -- Shortens path to leave 40 spaces in the window
							symbols = {
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
						},
					},
					lualine_x = { "filetype", nvimbattery },
				},
				tabline = {
					lualine_a = {
						"buffers",
					},
					lualine_z = {
						function()
							return require("nvim-treesitter").statusline({
								indicator_size = 70,
								type_patterns = { "class", "function", "method" },
								separator = " -> ",
							})
						end,
					},
				},
				extensions = {
					"nvim-tree",
					"oil",
					"quickfix",
				},
			})

			vim.keymap.set("n", "<S-Tab>", "<cmd>:bnext<CR>", { desc = "Go to next buffer" })
			vim.keymap.set("n", "<leader>cc", "<cmd>:bdelete<CR>", { desc = "Close current buffer" })
		end,
	},
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true,
			message_template = " <summary> • <date> • <author> • <<sha>>",
			date_format = "%r %m-%d-%Y %H:%M:%S",
			virtual_text_column = 1,
		},
	},
}
