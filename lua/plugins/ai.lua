return {
	{
		"olimorris/codecompanion.nvim",
		version = "^18.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "ravitemer/codecompanion-history.nvim", event = "VeryLazy", opts = {
				expiration_days = 10,
			} },
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
				cmd = "MCPHub",
			},
			{
				"franco-ruggeri/codecompanion-spinner.nvim",
				opts = {},
				event = "VeryLazy",
			},
			"j-hui/fidget.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("mcphub").setup({
				config = vim.fn.expand("~/.config/mcphub/servers.jsonc"),
			})

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
					history = {
						enabled = true,
					},
				},
				adapters = {
					acp = {
						opts = {
							show_presets = false,
						},
						opencode = require("codecompanion.adapters.acp.opencode"),
					},
					http = {
						opts = {
							show_presets = false,
							show_model_choices = true,
						},
						gemini = require("codecompanion.adapters.http.gemini"),
						openrouter = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								name = "openrouter",
								formatted_name = "OpenRouter",
								env = {
									url = "https://openrouter.ai/api",
									api_key = "OPENROUTER_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "moonshotai/kimi-dev-72b:free",
									},
								},
								handlers = {
									parse_message_meta = function(_, data)
										local extra = data.extra

										if extra and extra.reasoning then
											data.output.reasoning = { content = extra.reasoning }
											if data.output.content == "" then
												data.output.content = nil
											end
										end

										return data
									end,
								},
							})
						end,
						opencode_zen = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								name = "opencode_zen",
								formatted_name = "OpenCode Zen",
								env = {
									url = "https://opencode.ai/zen",
									api_key = "OPENCODE_API_KEY",
									chat_url = "/v1/chat/completions",
								},
								schema = {
									model = {
										default = "big-pickle",
									},
								},
							})
						end,
					},
				},
				interactions = {
					chat = {
						adapter = "gemini",
						model = "gemini-2.5-pro",
						opts = {
							system_prompt = require("utils.system_prompt"),
						},
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
		init = function()
			require("utils.codecompanion-fidget"):init()
		end,
	},
}
