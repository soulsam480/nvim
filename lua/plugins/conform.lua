return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			css = { "eslint_d" },
			html = { "eslint_d" },
			json = { "eslint_d" },
			yaml = { "eslint_d" },
			ruby = { "rubocop" },
			erb = { "rubocop" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 15000,
		},
	},
}
