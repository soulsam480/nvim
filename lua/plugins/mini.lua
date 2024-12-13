return {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.diff",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"chriskempson/base16-vim",
		},
		version = "*",
		config = function()
			local minidiff = require("mini.diff")

			minidiff.setup({
				view = {
					signs = { add = "++", change = "~~", delete = "--" },
					style = "sign",
				},
			})

			vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { fg = "#" .. vim.g.tinted_gui0B })
			vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { fg = "#" .. vim.g.tinted_gui0E })
			vim.api.nvim_set_hl(0, "MiniDiffSignChange", { fg = "#" .. vim.g.tinted_gui09 })

			vim.api.nvim_set_hl(0, "MiniDiffOverAdd", { fg = "#" .. vim.g.tinted_gui0B })
			vim.api.nvim_set_hl(0, "MiniDiffOverDelete", { fg = "#" .. vim.g.tinted_gui0E })
			vim.api.nvim_set_hl(0, "MiniDiffOverChange", { fg = "#" .. vim.g.tinted_gui09 })

			vim.keymap.set("n", "<leader>gd", function()
				require("mini.diff").toggle_overlay()
			end, {
				desc = "toggle git diff",
			})
		end,
	},
	{
		"echasnovski/mini.cursorword",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		version = "*",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		event = { "InsertEnter" },
		version = "*",
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"echasnovski/mini.clue",
		version = "*",
		event = "VeryLazy",
		config = function()
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					-- { mode = "n", keys = "z" },
					-- { mode = "x", keys = "z" },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
			})
		end,
	},
}