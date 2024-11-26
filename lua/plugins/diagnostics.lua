return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		keys = {
			{
				"[d",
				function()
					vim.diagnostic.open_float()
				end,
				{
					desc = "Lint: Show diagnostics",
				},
			},
		},
		config = function()
			local lint = require("lint")

			local js_linters = { "cspell" }

			lint.linters_by_ft = {
				javascript = js_linters,
				typescript = js_linters,
				typescriptreact = js_linters,
				javascriptreact = js_linters,
				svelte = js_linters,
			}

			local lint_au_group = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({
				"BufEnter",
				"BufWritePost",
			}, {
				group = lint_au_group,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
