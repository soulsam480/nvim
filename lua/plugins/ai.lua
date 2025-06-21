return {
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
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
				config = function()
					require("mcphub").setup()
				end,
			},
		},
		config = function()
			require("codecompanion").setup({
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							make_vars = true,
							make_slash_commands = true,
							show_result_in_chat = true,
						},
					},
				},
				strategies = {
					chat = {
						adapter = "gemini",
					},
					inline = {
						adapter = "gemini",
					},
					cmd = {
						adapter = "gemini",
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
