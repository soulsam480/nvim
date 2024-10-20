return {
	{
		"folke/flash.nvim",
		-- stylua: ignore
		keys = {
			{ "<leader>f",  mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "<leader>ft", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",          mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",          mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>",      mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"nvim-pack/nvim-spectre",
		keys = {
			{
				"<leader>S",
				mode = {
					"n",
				},
				'<cmd>lua require("spectre").toggle()<CR>',
				{
					desc = "Toggle Spectre",
				},
			},
			{
				"<leader>sw",
				mode = { "n" },
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				{
					desc = "Search current word",
				},
			},
			{
				"<leader>sw",
				mode = { "v" },
				'<esc><cmd>lua require("spectre").open_visual()<CR>',
				{
					desc = "Search current word",
				},
			},
			{
				"<leader>sp",
				mode = { "n" },
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				{
					desc = "Search on current file",
				},
			},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
				},
				-- FUCKING IRRITATING
				messages = {
					enabled = false,
				},
				lsp = {
					signature = {
						enabled = false,
					},
				},
			})
		end,
	},
	{
		"boltlessengineer/bufterm.nvim",
		event = "VeryLazy",
		config = function()
			require("bufterm").setup({
				remember_mode = false,
			})

			require("utils.lazygit").setup()

			local term = require("bufterm.terminal")
			local Terminal = require("bufterm.terminal").Terminal
			local ui = require("bufterm.ui")

			vim.keymap.set({ "n", "t" }, "<C-`>", function()
				local recent_term = term.get_recent_term()

				if not recent_term then
					recent_term = Terminal:new({})
				end

				if not recent_term.bufnr then
					recent_term:spawn()
				end

				ui.toggle_float(recent_term.bufnr)
				vim.cmd.startinsert()
			end, {
				desc = "Toggle Terminal",
			})
		end,
	},
}
