return {
	{
		"saghen/blink.cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		config = function()
			require("blink.cmp").setup({
				keymap = {
					-- show = "<C-space>",
					-- hide = "<C-e>",
					-- accept = "<Tab>",
					-- select_prev = { "<Up>", "<C-n>" },
					-- select_next = { "<Down>", "<C-p>" },
					--
					-- show_documentation = "<C-space>",
					-- hide_documentation = "<C-space>",
					-- scroll_documentation_up = "<C-b>",
					-- scroll_documentation_down = "<C-f>",
					--
					-- snippet_forward = "<C-n>",
					-- snippet_backward = "<C-p>",
					preset = "default",
					["<Tab>"] = { "select_and_accept" },

					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },

					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },

					["<C-n>"] = { "snippet_forward", "fallback" },
					["<C-p>"] = { "snippet_backward", "fallback" },
				},
				nerd_font_variant = "mono",
				completion = {
					accept = { auto_brackets = { enabled = true } },
					menu = {
						border = "rounded",
					},
					documentation = {
						auto_show = true,
						border = "rounded",
					},
				},
				signature = {
					enabled = true,
					window = {
						border = "rounded",
					},
				},
			})

			-- keep border style same across
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Pmenu" })
			vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "Pmenu" })
		end,
	},
}
