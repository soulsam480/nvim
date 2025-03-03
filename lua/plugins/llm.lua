return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				adapters = {

					-- ollama = function()
					-- 	return require("codecompanion.adapters").extend("ollama", {
					-- 		schema = {
					-- 			model = {
					-- 				default = "llama3.2:3b",
					-- 			},
					-- 		},
					-- 	})
					-- end,
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "ANTHROPIC_KEY",
							},
						})
					end,
				},
				strategies = {
					chat = { adapter = "ollama" },
					inline = { adapter = "ollama" },
					agent = { adapter = "ollama" },
				},
			})
		end,
	},
	-- {
	-- 	'milanglacier/minuet-ai.nvim',
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		{ 'nvim-lua/plenary.nvim' },
	-- 		{ 'Saghen/blink.cmp' },
	-- 	},
	-- 	config = function()
	-- 		require('minuet').setup({
	-- 			provider = 'openai_fim_compatible',
	-- 			n_completions = 1,
	-- 			context_window = 512,
	-- 			provider_options = {
	-- 				openai_fim_compatible = {
	-- 					api_key = 'DEEPSEEK_API_KEY',
	-- 					name = 'Ollama',
	-- 					end_point = 'http://localhost:11434/v1/completions',
	-- 					model = 'codellama:7b-code',
	-- 					optional = {
	-- 						max_tokens = 256,
	-- 						stop = { '\n\n' },
	-- 						top_p = 0.9,
	-- 					},
	-- 					template = {
	-- 						prompt = function(pref, suff)
	-- 							return '<PRE>' .. pref .. '<MID>' .. '<SUF>' .. suff
	-- 						end,
	-- 					}
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- }
}
