return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--no-ignore",
							"--hidden",
							"--files",
							"-g",
							"!**/node_modules/*",
							"-g",
							"!**/.git/*",
							"-g",
							"!**/node_modules",
							"-g",
							"!**/dist",
							"-g",
							"!**/.next",
							"-g",
							"!**/build",
							"-g",
							"!**/.out",
							"-g",
							"!**/.bundle",
							"-g",
							"!**/.git",
							"-g",
							"!**/.svn",
							"-g",
							"!**/.DS_Store",
							"-g",
							"!**/.vite-inspect",
							"-g",
							"!**/coverage",
						},
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
		keys = {
			{
				"<leader>ff",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files()
				end,
				{ desc = "Telescope find files" },
			},
			{
				"<leader>fg",
				function()
					local builtin = require("telescope.builtin")
					builtin.live_grep()
				end,
				{ desc = "Telescope live grep" },
			},
			{
				"<leader>fb",
				function()
					local builtin = require("telescope.builtin")
					builtin.buffers()
				end,
				{ desc = "Telescope buffers" },
			},
			{
				"<leader>fh",
				function()
					local builtin = require("telescope.builtin")
					builtin.help_tags()
				end,
				{ desc = "Telescope help tags" },
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		},
		config = function()
			-- disable netrw at the very start of your init.lua
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			vim.opt.termguicolors = true

			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				renderer = {
					full_name = true,
					group_empty = true,
					special_files = {},
					symlink_destination = false,
					indent_markers = {
						enable = true,
					},
					icons = {
						git_placement = "signcolumn",
						show = {
							file = true,
							folder = false,
							folder_arrow = true,
							git = true,
						},
					},
				},
				update_focused_file = {
					enable = true,
					update_root = true,
					ignore_list = { "help" },
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
				filters = {
					custom = {
						"^.git$",
					},
				},
			})
		end,
		keys = {
			{ "<leader>pp", ":NvimTreeToggle<CR>", { silent = true, desc = "Open Files" } },
			{ "<leader>p", ":NvimTreeFocus<CR>", { silent = true, desc = "Focus Files" } },
		},
	},
	{
		"stevearc/oil.nvim",
		keys = {
			{ "-", "<cmd>Oil<cr>", { desc = "open parent directory" } },
			{
				"<leader>-",
				function()
					require("oil").toggle_float()
				end,
				{ desc = "open parent directory in floating wIndow" },
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				columns = { "icon" },
			})
		end,
	},
}
