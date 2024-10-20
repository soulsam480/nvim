return {
	{
		"saghen/blink.cmp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = "rafamadriz/friendly-snippets",
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				show = "<C-space>",
				hide = "<C-e>",
				accept = "<Tab>",
				select_prev = { "<Up>", "<C-n>" },
				select_next = { "<Down>", "<C-p>" },

				show_documentation = "<C-space>",
				hide_documentation = "<C-space>",
				scroll_documentation_up = "<C-b>",
				scroll_documentation_down = "<C-f>",

				snippet_forward = "<C-n>",
				snippet_backward = "<C-p>",
			},
			nerd_font_variant = "mono",
			trigger = { signature_help = { enabled = true } },
			windows = {
				autocomplete = {
					border = "single",
				},
				documentation = {
					border = "single",
				},
			},
		},
	},
}
