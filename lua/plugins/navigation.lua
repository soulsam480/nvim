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
			local previewers = require("telescope.previewers")

			local new_maker = function(filepath, bufnr, opts)
				opts = opts or {}

				filepath = vim.fn.expand(filepath)

				-- we need to return nil if file path contains env or secrets
				if filepath:match("env") or filepath:match("secrets") then
					return nil
				else
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				end
			end

			require("telescope").setup({
				defaults = {
					-- path_display = { "smart" },
					buffer_previewer_maker = new_maker,
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					recent_files = {
						only_cwd = true
					}
				},
				pickers = {
					buffers = {
						path_display = { "smart" },
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
						-- previewer = false,
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
							"-g",
							"!**/debug",
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
					require("telescope").extensions.recent_files.pick({
						previewer = false,
					})
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
			{
				"<leader>fl",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Telescipe live grep",
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
			{ "<leader>p",  ":NvimTreeFocus<CR>",  desc = "Focus Files" },
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
}
