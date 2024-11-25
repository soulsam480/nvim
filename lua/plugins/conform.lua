return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "biome" },
			typescript = { "biome" },
			typescriptreact = { "biome" },
			javascriptreact = { "biome" },
			css = { "biome" },
			html = { "biome" },
			json = { "biome" },
			yaml = { "biome" },
			ruby = { "rubocop" },
			eruby = { "rubocop" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 15000 * 4,
		},
	},
}
