return {
	{
		"saghen/blink.cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"xzbdmw/colorful-menu.nvim",
			},
		},
		version = "v0.*",
		config = function()
			require("blink.cmp").setup({
				sources = {
					cmdline = {},
					providers = {
						snippets = {
							score_offset = 0,
						},
					},
					default = {
						"lsp",
						"path",
						"buffer",
						"snippets",
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
							-- columns = { { "kind_icon" }, { "label", gap = 1 } },
							components = {
								label = {
									text = require("colorful-menu").blink_components_text,
									highlight = require("colorful-menu").blink_components_highlight,
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
						Copilot = "",
					},
				},
			})

			-- keep border style same across
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "Pmenu" })
			vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "Pmenu" })
		end,
	},
}
