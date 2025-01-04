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
			{
				"xzbdmw/colorful-menu.nvim"
			}
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
								local CompletionItemKind = require("blink.cmp.types")
								    .CompletionItemKind
								local kind_idx = #CompletionItemKind + 1

								CompletionItemKind[kind_idx] = "Copilot"

								for _, item in ipairs(items) do
									item.kind = kind_idx
								end

								return items
							end,
						},
						snippets = {
							score_offset = 0
						}
					},
					default = {
						"lsp",
						"path",
						"buffer",
						"snippets",
						"copilot",
					},
				},
				keymap = {
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
					keyword = {
						range = "full",
					},
					accept = { auto_brackets = { enabled = true } },
					menu = {
						border = "rounded",
						draw = {
							components = {
								kind_icon = {
									ellipsis = false,
									text = function(ctx)
										return require("lspkind").symbolic(
											ctx.kind, {
												mode = "symbol",
											})
									end,
								},
								label = {
									width = { fill = true, max = 60 },
									text = function(ctx)
										local highlights_info =
										    require("colorful-menu").highlights(
											    ctx.item, vim.bo.filetype)
										if highlights_info ~= nil then
											return highlights_info.text
										else
											return ctx.label
										end
									end,
									highlight = function(ctx)
										local highlights_info =
										    require("colorful-menu").highlights(
											    ctx.item, vim.bo.filetype)
										local highlights = {}
										if highlights_info ~= nil then
											for _, info in ipairs(highlights_info.highlights) do
												table.insert(highlights,
													{
														info.range
														    [1],
														info.range
														    [2],
														group =
														    ctx.deprecated and
														    "BlinkCmpLabelDeprecated" or
														    info[1],
													})
											end
										end
										for _, idx in ipairs(ctx.label_matched_indices) do
											table.insert(highlights,
												{
													idx,
													idx + 1,
													group =
													"BlinkCmpLabelMatch"
												})
										end
										return highlights
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
					nerd_font_variant = "Nerd Font Mono",
				},
			})

			-- keep border style same across
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Pmenu" })
			vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "Pmenu" })
		end,
	},
}
