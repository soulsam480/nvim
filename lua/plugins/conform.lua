return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascriptreact = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			ruby = { "rubocop" },
			erb = { "rubocop" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 15000 * 4,
		},
	},
}
