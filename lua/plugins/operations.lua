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
		opts = {
			replace_engine = {
				["sed"] = {
					cmd = "sed",
					args = {
						"-i",
						"",
						"-E",
					},
				},
			},
		},
		keys = {
			{
				"<leader>S",
				mode = {
					"n",
				},
				'<cmd>lua require("spectre").toggle()<CR>',
				desc = "Toggle Spectre",
			},
			{
				"<leader>sw",
				mode = { "n" },
				'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
				desc = "Search current word",
			},
			{
				"<leader>sw",
				mode = { "v" },
				'<esc><cmd>lua require("spectre").open_visual()<CR>',
				desc = "Search current word",
			},
			{
				"<leader>sp",
				mode = { "n" },
				'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
				desc = "Search on current file",
			},
		},
	},
	{
		"folke/noice.nvim",
		-- tag = "v4.*",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					signature = {
						view = nil,
						enabled = false,
					},
					hover = {
						view = nil,
						enabled = true,
					},
					-- documentation = {
					-- 	view = nil,
					-- },
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
					message = {
						enabled = false,
					},
				},
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
						filter = { event = { "msg_showmode" } },
						opts = { skip = true },
					},
					{
						filter = {
							event = "notify",
							find = "No information available",
						},
						opts = { skip = true },
					},
					{
						filter = {
							event = "msg_show",
							find = "%f[%a]written%f[%A]",
						},
						opts = { skip = true },
					},
				},
				popupmenu = {
					backend = "cmp",
				},
			})

			-- keep the same as blink.cmp
			vim.api.nvim_set_hl(0, "NoicePopupBorder", { link = "Pmenu" })
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({})
			require("utils.lazygit").setup()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "zsh",
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		keys = {
			{
				"<C-`>",
				mode = {
					"n",
					"t",
				},
				function()
					if vim.bo.filetype == "toggleterm" then
						vim.cmd("close")
						return
					end

					vim.cmd("1ToggleTerm direction=float name=Terminal")
				end,
				desc = "Toggle Terminal",
			},
		},
	},
	{
		"ruifm/gitlinker.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitlinker").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
	{
		"gregorias/coerce.nvim",
		event = { "BufReadPre", "BufNewFile" },
		tag = "v3.0.0",
		config = true,
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		config = true,
		opts = {

			ignore_filetype = {
				"undotree",
				"undotreeDiff",
				"qf",
				"TelescopePrompt",
				"spectre_panel",
				"tsplayground",
				"BufTerm",
				"oil",
			},
			window = {
				winblend = 30,
			},
			keymaps = {
				["<Down>"] = "move_next",
				["<Up>"] = "move_prev",
				["gj"] = "move2parent",
				["J"] = "move_change_next",
				["K"] = "move_change_prev",
				["<cr>"] = "action_enter",
				["p"] = "enter_diffbuf",
				["q"] = "quit",
			},
		},
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup({
				keys = {
					telescope = {
						i = {
							paste = "<cr>",
						},
					},
				},
			})
		end,
		keys = {
			{
				"<leader>fp",
				mode = { "n" },
				function()
					require("telescope").extensions.neoclip.default()
				end,
				desc = "Open yank register",
			},
		},
	},
	{ "chrisgrieser/nvim-spider", event = { "BufReadPre", "BufNewFile" } },
	{
		"denialofsandwich/sudo.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = true,
	},
}
