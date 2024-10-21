return {
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

		lint.linters_by_ft = {
			javascript = { "cspell" },
			typescript = { "cspell" },
			typescriptreact = { "cspell" },
			javascriptreact = { "cspell" },
			svelte = { "eslint" },
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
}
