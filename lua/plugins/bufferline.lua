return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local bufferline = require("bufferline")

			bufferline.setup({
				options = {
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							highlight = "Directory",
							separator = false,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>t", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>ty", ":BufferClose<CR>", { noremap = true, silent = true })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			-- local harpoon = require("harpoon")
			--
			-- -- REQUIRED
			-- harpoon:setup({
			-- 	settings = {
			-- 		save_on_toggle = false,
			-- 	},
			-- })
			-- -- REQUIRED

			-- vim.keymap.set("n", "<leader>a", function()
			-- 	harpoon:list():add()
			-- end)
			-- -- vim.keymap.set("n", "<C-e>", function()
			-- -- 	harpoon.ui:toggle_quick_menu(harpoon:list())
			-- -- end)
			--
			-- -- vim.keymap.set("n", "<C-h>", function()
			-- -- 	harpoon:list():select(1)
			-- -- end)
			-- -- vim.keymap.set("n", "<C-t>", function()
			-- -- 	harpoon:list():select(2)
			-- -- end)
			-- -- vim.keymap.set("n", "<C-n>", function()
			-- -- 	harpoon:list():select(3)
			-- -- end)
			-- -- vim.keymap.set("n", "<C-s>", function()
			-- -- 	harpoon:list():select(4)
			-- -- end)
			--
			-- -- Toggle previous & next buffers stored within Harpoon list
			-- vim.keymap.set("n", "<leader>1", function()
			-- 	harpoon:list():prev()
			-- end)
			-- vim.keymap.set("n", "<leader>2", function()
			-- 	harpoon:list():next()
			-- end)
			--
			-- -- basic telescope configuration
			-- local conf = require("telescope.config").values
			-- local function toggle_telescope(harpoon_files)
			-- 	local file_paths = {}
			-- 	for _, item in ipairs(harpoon_files.items) do
			-- 		table.insert(file_paths, item.value)
			-- 	end
			--
			-- 	require("telescope.pickers")
			-- 		.new({}, {
			-- 			prompt_title = "Harpoon",
			-- 			finder = require("telescope.finders").new_table({
			-- 				results = file_paths,
			-- 			}),
			-- 			previewer = conf.file_previewer({}),
			-- 			sorter = conf.generic_sorter({}),
			-- 		})
			-- 		:find()
			-- end
			--
			-- vim.keymap.set("n", "<C-e>", function()
			-- 	toggle_telescope(harpoon:list())
			-- end, { desc = "Open harpoon window" })
		end,
	},
}
