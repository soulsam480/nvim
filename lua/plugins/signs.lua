return {
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"justinhj/battery.nvim",
			"nvim-tree/nvim-web-devicons",
			"justinhj/battery.nvim",
			{ "AndreM222/copilot-lualine" },
		},
		config = function()
			require("battery").setup({
				update_rate_seconds = 30,
				show_status_when_no_battery = true,
				show_plugged_icon = true,
				show_unplugged_icon = true,
				battery_threshold = 25,
			})

			require("utils.fta").setup()

			local nvimbattery = {
				function()
					return require("battery").get_status_line()
				end,
				color = { fg = vim.g.tinted_gui0B, bg = vim.g.tinted_gui01 },
			}

			local fta = {
				require("utils.fta").get_lualine_component(),
				color = { fg = vim.g.tinted_gui08, bg = vim.g.tinted_gui01, gui = "bold" },
			}

			local noice_search = {
				require("noice").api.status.search.get,
				cond = require("noice").api.status.search.has,
				color = { fg = "#ff9e64" },
			}

			require("lualine").setup({
				options = {
					theme = "base16",
					component_separators = "",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "", right = "" } },
						{
							require("utils.now_playing").now_playing_component,
							separator = { left = "", right = "" },
							color = {
								bg = vim.g.tinted_gui01,
								fg = vim.g.tinted_gui0D,
							},
						},
					},
					lualine_b = { "branch", "diff" },
					lualine_c = {},
					lualine_x = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
						noice_search,
						fta,
						"filetype",
						nvimbattery,
					},
				},
				tabline = {
					lualine_a = {
						{ "buffers" },
					},
				},
				winbar = {

					lualine_a = {
						{
							"diagnostics",
							symbols = { error = " ", warn = " ", info = " " },
							color = { bg = vim.g.tinted_gui01 },
							separator = { left = "", right = "" },
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
								newfile = "[New File]", -- Text to show for newly created file before first write
							},
							color = {
								bg = vim.g.tinted_gui02,
								fg = vim.g.tinted_gui06,
							},
							separator = { left = "", right = "" },
						},
						{
							function()
								return require("nvim-treesitter").statusline({
									indicator_size = 70,
									type_patterns = { "class", "function", "method" },
									separator = " -> ",
								})
							end,
							color = {
								bg = vim.g.tinted_gui00,
								fg = vim.g.tinted_gui0A,
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
		event = "LSPAttach",
		priority = 1000,
		-- commit = "867902d5974a18c156c918ab8addbf091719de27",
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					throttle = 50,
					multilines = true,
					show_all_diags_on_cursorline = true,
					format = function(diagnostic)
						local message = diagnostic.message .. " [" .. (diagnostic.source or "")

						local rule_name = diagnostic.user_data
							and diagnostic.user_data.lsp
							and diagnostic.user_data.lsp.code

						if rule_name then
							message = message .. "]" .. " (" .. rule_name .. ")"
						else
							message = message .. "]"
						end

						return message
					end,
				},
				preset = "ghost",
			})
		end,
	},
	{
		"rasulomaroff/reactive.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			builtin = {
				cursorline = true,
				cursor = true,
				modemsg = true,
			},
		},
	},
	{
		"nvzone/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			timeout = 1,
			maxkeys = 5,
			position = "top-right",
		},
	},
}
