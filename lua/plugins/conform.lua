return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local js_formatters = {}

		if require("utils.linter").has_linter("biome") then
			table.insert(js_formatters, "biome")
		else
			table.insert(js_formatters, "prettierd")
		end

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = js_formatters,
				typescript = js_formatters,
				typescriptreact = js_formatters,
				javascriptreact = js_formatters,
				css = js_formatters,
				html = js_formatters,
				json = js_formatters,
				yaml = js_formatters,
				ruby = { "rubocop" },
				eruby = { "rubocop" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 15000 * 4,
			},
		})
	end,
}
