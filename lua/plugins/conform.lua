return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local js_formatters = {}

		if require("utils.linter").has_linter("prettier") and not require("utils.linter").has_linter("biome") then
			table.insert(js_formatters, "prettierd")
		elseif require("utils.linter").has_linter("eslint-format") then
			table.insert(js_formatters, "eslint_format")
		else
			table.insert(js_formatters, "biome")
		end

		require("conform").setup({
			formatters = {
				-- NOTE: the trick here is making conform run echo command but it's actually running eslint fix all command to format
				-- it only works when .eslintformat file is present in root
				eslint_format = {
					meta = {
						url = "",
						description = "Eslint lsp formatting. add .eslintformat file to enable",
					},
					command = function(_, ctx)
						vim.api.nvim_buf_call(ctx.buf, function()
							vim.cmd("EslintFixAll")
						end)

						return "echo"
					end,
				},
			},
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
				markdown = { "deno_fmt" },
				vue = { "deno_fmt" }
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 15000 * 4,
			},
		})
	end,
}
