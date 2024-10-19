return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",
		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				show = "<C-space>",
				hide = "<C-e>",
				accept = "<CR>",
				select_prev = { "<Up>", "<S-Tab>" },
				select_next = { "<Down>", "<Tab>" },

				show_documentation = "<C-space>",
				hide_documentation = "<C-space>",
				scroll_documentation_up = "<C-b>",
				scroll_documentation_down = "<C-f>",

				snippet_forward = "<Tab>",
				snippet_backward = "<S-Tab>",
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
