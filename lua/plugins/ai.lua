return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "ravitemer/codecompanion-history.nvim", event = "VeryLazy" },
			{
				"OXY2DEV/markview.nvim",
				lazy = false,
				opts = {
					preview = {
						filetypes = { "markdown", "codecompanion" },
						ignore_buftypes = {},
					},
				},
			},
			{
				"ravitemer/mcphub.nvim",
				build = "npm install -g mcp-hub@latest",
				opts = {},
				event = "VeryLazy",
			},
			{
				"franco-ruggeri/codecompanion-spinner.nvim",
				opts = {},
				event = "VeryLazy",
			},
		},
		event = "VeryLazy",
		config = function()
			require("mcphub").setup({})

			require("codecompanion").setup({
				opts = {
					system_prompt = require("utils.system_prompt"),
				},
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							make_vars = true,
							make_slash_commands = true,
							show_result_in_chat = true,
						},
					},
					history = {
						enabled = true,
					},
				},
				strategies = {
					chat = {
						adapter = "gemini",
						model = "gemini-2.5-pro",
					},
					inline = {
						adapter = "gemini",
						model = "gemini-2.5-pro",
					},
					cmd = {
						adapter = "gemini",
						model = "gemini-2.5-pro",
					},
				},
			})
		end,
		keys = {
			{
				"<leader>ai",
				"<cmd>CodeCompanionChat Toggle<cr>",
				desc = "Toggle AI Chat",
			},
			{
				"<leader>aa",
				":'<,'>CodeCompanionChat Add<CR>",
				mode = "x",
				desc = "Add selection to Chat",
			},
		},
	},
}
