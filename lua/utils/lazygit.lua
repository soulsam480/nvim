-- this will add Terminal to the list (not starting job yet)
local Terminal = require("bufterm.terminal").Terminal
local ui = require("bufterm.ui")

local M = {}

M.setup = function()
	local lazygit = Terminal:new({
		cmd = "lazygit",
		buflisted = false,
		termlisted = false, -- set this option to false if you treat this terminal as single independent terminal
	})

	vim.keymap.set("n", "<leader>g", function()
		-- spawn terminal (terminal won't be spawned if self.jobid is valid)
		lazygit:spawn()
		-- open floating window
		ui.toggle_float(lazygit.bufnr)
	end, {
		desc = "Open LazyGit",
	})
end

return M
