return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- lua
					null_ls.builtins.formatting.stylua,
					-- js
					null_ls.builtins.formatting.prettier,

					-- null_ls.builtins.diagnostics.eslint_d,
					-- ruby
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.diagnostics.rubocop,

					on_attach = function(client, bufnr)
						require("utils.formatting").format_on_write(client, bufnr)
					end,
				},
			})
		end,
	},
}
