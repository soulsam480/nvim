return {
	{
		"saghen/blink.cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"xzbdmw/colorful-menu.nvim",
			},
			{
				"saghen/blink.compat",
				version = "*",
				lazy = true,
				opts = {},
			},
			{
				"supermaven-inc/supermaven-nvim",
				config = function()
					require("supermaven-nvim").setup({
						isable_keymaps = true,
						disable_inline_completion = true,
					})
				end,
			},
			-- { "Kaiser-Yang/blink-cmp-avante" },
		},
		version = "1.*",
		config = function()
			require("blink.cmp").setup({
				fuzzy = { implementation = "rust" },
				sources = {
					providers = {
						snippets = {
							score_offset = 7,
						},
						lsp = {
							score_offset = 10,
						},
						path = { score_offset = 9 },
						buffer = {
							score_offset = 8,
						},
						supermaven = {
							name = "supermaven", -- IMPORTANT: use the same name as you would for nvim-cmp
							module = "blink.compat.source",
							score_offset = 100,
							async = true,
							transform_items = function(_, items)
								local CompletionItemKind = require("blink.cmp.types")
								    .CompletionItemKind
								local kind_idx = #CompletionItemKind + 1
								CompletionItemKind[kind_idx] = "Supermaven"
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
						"supermaven",
					},
				},
				keymap = {
					preset = "default",
					["<Tab>"] = { "accept", "fallback" },

					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },

					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },

					["<C-n>"] = { "snippet_forward", "fallback" },
					["<C-p>"] = { "snippet_backward", "fallback" },
				},
				completion = {
					ghost_text = {
						enabled = false,
					},
					keyword = {
						range = "full",
					},
					accept = { auto_brackets = { enabled = false } },
					menu = {
						border = "rounded",
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu")
										    .blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu")
										    .blink_components_highlight(ctx)
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
					list = {
						selection = {
							preselect = true,
							auto_insert = false,
						},
					},
				},
				cmdline = {
					completion = {
						menu = { auto_show = true },
					},
					keymap = {
						["<Tab>"] = { "accept", "fallback" },
						["<Up>"] = { "select_prev", "fallback" },
						["<Down>"] = { "select_next", "fallback" },
					},
				},
				signature = {
					enabled = true,
					window = {
						border = "rounded",
					},
				},
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
					kind_icons = {
						Text = "",
						Method = "",
						Function = "",
						Constructor = "",
						Field = "",
						Variable = "",
						Class = "",
						Interface = "",
						Module = "",
						Property = "",
						Unit = "",
						Value = "",
						Enum = "",
						Keyword = "",
						Snippet = "",
						Color = "",
						File = "",
						Reference = "",
						Folder = "",
						EnumMember = "",
						Constant = "",
						Struct = "",
						Event = "",
						Operator = "",
						TypeParameter = "",
						Supermaven = " ",
					},
				},
			})

			-- keep border style same across
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Pmenu" })
			vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "Pmenu" })
			vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "VirtText" })
		end,
	},
}
