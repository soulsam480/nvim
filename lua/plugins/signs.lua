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
					component_separators = "",
					section_separators = { left = "", right = "" },
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
					lualine_b = { "branch", "diff" },
					lualine_c = {},
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
				winbar = {
					lualine_a = {
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " " },
							color = { bg = vim.g.base16_gui01 },
						},
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 3,
							shorting_target = 100, -- Shortens path to leave 40 spaces in the window
							symbols = {
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for newly created file before first write
							},
							color = {
								bg = vim.g.base16_gui01,
								fg = vim.g.base16_gui0D,
							},
						},
					},
				},
				extensions = {
					"nvim-tree",
					"oil",
					"quickfix",
				},
			})
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
			set_extmark_options = {
				priority = 0,
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "BufReadPre",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					show_source = true,
					multilines = true,
				},
				preset = "amongus",
			})
		end,
	},
	{
		"svampkorg/moody.nvim",
		event = { "ModeChanged", "BufWinEnter", "WinEnter" },
		config = function()
			vim.api.nvim_set_hl(0, "NormalMoody", { fg = "#" .. vim.g.base16_gui0D }) -- blue
			vim.api.nvim_set_hl(0, "InsertMoody", { fg = "#" .. vim.g.base16_gui0B }) -- green
			vim.api.nvim_set_hl(0, "VisualMoody", { fg = "#" .. vim.g.base16_gui0E }) -- pink
			vim.api.nvim_set_hl(0, "CommandMoody", { fg = "#" .. vim.g.base16_gui08 }) -- maroon
			vim.api.nvim_set_hl(0, "OperatorMoody", { fg = "#" .. vim.g.base16_gui08 }) -- maroon
			vim.api.nvim_set_hl(0, "ReplaceMoody", { fg = "#" .. vim.g.base16_gui09 }) -- red
			vim.api.nvim_set_hl(0, "SelectMoody", { fg = "#" .. vim.g.base16_gui0E }) -- pink
			vim.api.nvim_set_hl(0, "TerminalMoody", { fg = "#" .. vim.g.base16_gui05 }) -- mauve
			vim.api.nvim_set_hl(0, "TerminalNormalMoody", { fg = "#" .. vim.g.base16_gui05 }) -- mauve
		end,
	},
}
