return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		-- tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"smartpde/telescope-recent-files",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					path_display = { "smart" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					fzf = {},
				},
				pickers = {
					buffers = {
						file_ignore_patterns = { "term:" },
						theme = "dropdown",
						previewer = false,
						mappings = {
							n = {
								["<Tab>"] = actions.move_selection_next,
								["<S-Tab>"] = actions.move_selection_previous,
							},
						},
					},
					colorscheme = {
						enable_preview = true,
					},
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
							"-g",
							"!**/package-lock.json",
							"-g",
							"!**/yarn.lock",
							"-g",
							"!**/CHANGELOG.md",
							"-g",
							"!**/vendor",
							"-g",
							"!**/tmp",
							"-g",
							"!**/.svelte-kit",
							"-g",
							"!**/.vercel",
							"-g",
							"!**/.vinxi",
							"-g",
							"!**/.venv",
							"-g",
							"!**/__pycache__",
						},
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("recent_files")
			require("telescope").load_extension("neoclip")
			require("telescope").load_extension("noice")
		end,
		keys = {
			{
				"<leader>ff",
				function()
					local builtin = require("telescope.builtin")
					builtin.find_files()
				end,
				desc = "Telescope find files",
			},
			-- https://github.com/radlinskii/dotfiles/blob/main/nvim_config/lua/radlinskii/plugins/telescope.lua
			{
				"<S-Tab>",
				function()
					local builtin = require("telescope.builtin")

					builtin.buffers({
						sort_lastused = true,
						sort_mru = true,
					})
				end,
				desc = "Open buffers",
			},
			{
				"<leader>fg",
				function()
					local builtin = require("telescope.builtin")
					builtin.git_status()
				end,
				desc = "Telescope changed files",
			},
			{
				"<leader>fr",
				function()
					require("telescope").extensions.recent_files.pick()
				end,
				desc = "Telescope find recent files",
			},
			{
				"<leader>fd",
				function()
					require("telescope.builtin").diagnostics({ bufnr = 0 })
				end,
				desc = "Open diagnostics for this file",
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
			{ "<leader>pp", ":NvimTreeToggle<CR>", desc = "Open Files" },
			{ "<leader>p", ":NvimTreeFocus<CR>", desc = "Focus Files" },
		},
	},
	{
		"stevearc/oil.nvim",
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "open parent directory" },
			{
				"<leader>-",
				function()
					require("oil").toggle_float()
				end,
				desc = "open parent directory in floating wIndow",
			},
		},
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				columns = { "icon", "size" },
				delete_to_trash = false,
				view_options = {
					-- show_hidden = true,
					-- is_hidden_file = function(name)
					-- 	return vim.startswith(name, ".git")
					-- end,
					lsp_file_methods = {
						-- Enable or disable LSP file operations
						enabled = true,
						-- Time to wait for LSP file operations to complete before skipping
						timeout_ms = 1000,
						-- Set to true to autosave buffers that are updated with LSP willRenameFiles
						-- Set to "unmodified" to only save unmodified buffers
						autosave_changes = true,
					},
				},
			})
		end,
	},
	{
		"niqodea/lasso.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lasso = require("lasso")
			lasso.setup({
				-- marks_tracker_path = 'custom/path/to/marks/tracker'
			})

			-- Mark current file
			vim.keymap.set("n", vim.g.mapleader .. "m", function()
				lasso.mark_file()
			end, { desc = "Lasso: mark current file" })

			-- Go to marks tracker (editable, use `gf` to go to file under cursor)
			vim.keymap.set("n", vim.g.mapleader .. "M", function()
				lasso.open_marks_tracker()
			end, { desc = "Lasso: open marks" })

			-- Jump to n-th marked file (n-th line of marks tracker)
			vim.keymap.set("n", vim.g.mapleader .. "1", function()
				lasso.open_marked_file(1)
			end, { desc = "Lasso: go to 1st mark" })
			vim.keymap.set("n", vim.g.mapleader .. "2", function()
				lasso.open_marked_file(2)
			end, { desc = "Lasso: go to 2nd mark" })
			vim.keymap.set("n", vim.g.mapleader .. "3", function()
				lasso.open_marked_file(3)
			end, { desc = "Lasso: go to 3rd mark" })
			vim.keymap.set("n", vim.g.mapleader .. "4", function()
				lasso.open_marked_file(4)
			end, { desc = "Lasso: go to 4th mark" })

			vim.keymap.set("n", vim.g.mapleader .. "5", function()
				lasso.open_marked_file(5)
			end, { desc = "Lasso: go to 5th mark" })
		end,
	},
	-- {
	-- 	"aaronik/treewalker.nvim",
	-- 	config = function()
	-- 		vim.keymap.set({ "n", "v" }, "<C-u>", function()
	-- 			if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
	-- 				vim.cmd(":Treewalker Up")
	-- 			end
	-- 		end, {
	-- 			silent = true,
	-- 			desc = "[T]reewalker [u]p",
	-- 		})
	--
	-- 		vim.keymap.set({ "n", "v" }, "<C-d>", function()
	-- 			if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
	-- 				vim.cmd(":Treewalker Down")
	-- 			end
	-- 		end, {
	-- 			silent = true,
	-- 			desc = "[T]reewalker down",
	-- 		})
	-- 	end,
	-- },
}
