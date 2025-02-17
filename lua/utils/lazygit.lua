local Terminal = require("toggleterm.terminal").Terminal

local M = {}

M.setup = function()
	local lazygit = Terminal:new({
		name = "LazyGit",
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "double",
		},
		-- function to run on opening the terminal
		on_open = function(term)
			vim.cmd("startinsert!")
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
		end,
		-- function to run on closing the terminal
		on_close = function()
			vim.cmd("startinsert!")
		end,
	})

	vim.keymap.set("n", "<leader>g", function()
		lazygit:toggle()
	end, { noremap = true, silent = true, desc = "Open LazyGit" })
end

return M
