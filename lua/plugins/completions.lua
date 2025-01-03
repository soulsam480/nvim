return {
	{
		"saghen/blink.cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				config = function()
					require("copilot").setup({
						suggestion = { enabled = false },
						panel = { enabled = false },
					})
				end,
			},
			{
				"giuxtaposition/blink-cmp-copilot",
			},
			{
				"onsails/lspkind.nvim",
			},
		},
		version = "v0.*",
		config = function()
			require("lspkind").setup({
				symbol_map = {
					Copilot = "",
				},
			})

			require("blink.cmp").setup({
				sources = {
					cmdline = {},
					providers = {
						copilot = {
							name = "copilot",
							module = "blink-cmp-copilot",
							score_offset = 100,
							async = true,
							transform_items = function(_, items)
								local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
								local kind_idx = #CompletionItemKind + 1

								CompletionItemKind[kind_idx] = "Copilot"

								for _, item in ipairs(items) do
									item.kind = kind_idx
								end

								return items
							end,
						},
					},
					default = {
						"lsp",
						"path",
						"buffer",
						"snippets",
						-- "copilot",
					},
				},
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
				completion = {
					accept = { auto_brackets = { enabled = true } },
					menu = {
						border = "rounded",
						draw = {
							components = {
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										return require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end,
								},
							},
						},
					},
					documentation = {
						auto_show = true,
						window = {
							border = "rounded",
						},
					},
				},
				signature = {
					enabled = true,
					window = {
						border = "rounded",
					},
				},
				appearance = {
					nerd_font_variant = "mono",
				},
			})

			-- keep border style same across
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Pmenu" })
			vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "Pmenu" })
		end,
	},
}
