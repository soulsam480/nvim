return {
	{
		"folke/todo-comments.nvim",
		event = { "VeryLazy" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- keywords = {
			-- 	FIX = { alt = { "!" } },
			-- 	NOTE = { alt = { "?" } },
			-- },
		},
	},
	{
		"tinted-theming/base16-vim",
		config = function()
			vim.g.tinted_colorspace = 256
			vim.cmd.colorscheme(require("config.color-scheme").scheme)

			vim.api.nvim_set_hl(0, "NormalMoody", { fg = "#" .. vim.g.tinted_gui0D }) -- blue
			vim.api.nvim_set_hl(0, "InsertMoody", { fg = "#" .. vim.g.tinted_gui0B }) -- green
			vim.api.nvim_set_hl(0, "VisualMoody", { fg = "#" .. vim.g.tinted_gui0E }) -- pink
			vim.api.nvim_set_hl(0, "CommandMoody", { fg = "#" .. vim.g.tinted_gui08 }) -- maroon
			vim.api.nvim_set_hl(0, "OperatorMoody", { fg = "#" .. vim.g.tinted_gui08 }) -- maroon
			vim.api.nvim_set_hl(0, "ReplaceMoody", { fg = "#" .. vim.g.tinted_gui09 }) -- red
			vim.api.nvim_set_hl(0, "SelectMoody", { fg = "#" .. vim.g.tinted_gui0E }) -- pink
			vim.api.nvim_set_hl(0, "TerminalMoody", { fg = "#" .. vim.g.tinted_gui05 }) -- mauve
			vim.api.nvim_set_hl(0, "TerminalNormalMoody", { fg = "#" .. vim.g.tinted_gui05 }) -- mauve

			-- TODO: remove once lua line migrates to new version of base16

			vim.g.base16_gui00 = vim.g.tinted_gui00
			vim.g.base16_gui01 = vim.g.tinted_gui01
			vim.g.base16_gui02 = vim.g.tinted_gui02
			vim.g.base16_gui03 = vim.g.tinted_gui03
			vim.g.base16_gui04 = vim.g.tinted_gui04
			vim.g.base16_gui05 = vim.g.tinted_gui05
			vim.g.base16_gui06 = vim.g.tinted_gui06
			vim.g.base16_gui07 = vim.g.tinted_gui07
			vim.g.base16_gui08 = vim.g.tinted_gui08
			vim.g.base16_gui09 = vim.g.tinted_gui09
			vim.g.base16_gui0A = vim.g.tinted_gui0A
			vim.g.base16_gui0B = vim.g.tinted_gui0B
			vim.g.base16_gui0C = vim.g.tinted_gui0C
			vim.g.base16_gui0D = vim.g.tinted_gui0D
			vim.g.base16_gui0E = vim.g.tinted_gui0E
			vim.g.base16_gui0F = vim.g.tinted_gui0F
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local dash = require("alpha.themes.theta")

			dash.file_icons.provider = "devicons"

			dash.header.val = {
				[[                :=---                            ----.                ]],
				[[               :*   .+       .--======--.       =:   +:               ]],
				[[             =-.    =-    .=++=--------=++=.    -+    .-=             ]],
				[[             *       :=: +*=*=+=-------==++*+ .=-       *             ]],
				[[             .=--==:   -%+=*=#=*=======+*=#==%=   :==--=.             ]],
				[[                   .=- #%%%%%%%%%%%%%%%%%%%%%%@.:=:                   ]],
				[[                 ::::-#@@@@@@@@@@@@@@@@@@@@@@@@%=::::                 ]],
				[[                :#+++++++++++++++++++++++++++++++++++*                ]],
				[[                      .*   .-**+:    :+**=.   ==                      ]],
				[[                       +:  +@@@@@=  :@@@@@#  .#                       ]],
				[[                        +: =@@@@@=  :@@@@@# .*                        ]],
				[[                         -+.:+*+: -= .=++-.+=                         ]],
				[[                           *#=:.  ==  .:=##                           ]],
				[[                         -=++ .*--++--*. +==-                         ]],
				[[                       ==  #.-=#--=+--#--:*  ==                       ]],
				[[                 =---=-   .#=-+=  :-  +--=#    ==----                 ]],
				[[                .+      .=-*   :------:   *-=.      +                 ]],
				[[                 ---.   +: .+            +. :+   .---                 ]],
				[[                   :+   +.   ---.    .:--   :=   +.                   ]],
			}

			require("alpha").setup(dash.config)
		end,
	},
	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		config = function()
			local notify = require("notify")

			notify.setup({
				background_colour = "#000000",
				enabled = true,
			})
		end,
	},
}
