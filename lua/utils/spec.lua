local Terminal = require("toggleterm.terminal").Terminal
local Path = require("plenary.path")

local M = {}

-- Helper function to get relative path from cwd
local function get_relative_path(filepath)
	local cwd = vim.fn.getcwd()
	local path = Path:new(filepath)
	return path:make_relative(cwd)
end

M.file_type_to_command = {
	ruby = function()
		return {
			"docker",
			"compose",
			"exec",
			"api",
			"bundle",
			"exec",
			"rspec",
			get_relative_path(vim.fn.expand("%:p")) .. ":" .. vim.fn.line("."),
		}
	end,
}

-- Helper function to get the command for current filetype
local function get_command_for_filetype()
	local current_ft = vim.bo.filetype
	local command_fn = M.file_type_to_command[current_ft]

	if not command_fn then
		return nil
	end

	local command_parts = command_fn()
	-- Convert line number to string and join all parts with spaces
	command_parts[#command_parts] = tostring(command_parts[#command_parts])
	return table.concat(command_parts, " ")
end

M.setup = function()
	local specterm = nil

	local function create_or_get_terminal()
		if specterm then
			return specterm
		end

		specterm = Terminal:new({
			id = 2,
			dir = "git_dir",
			disply_name = "Specs",
			direction = "float",
			float_opts = {
				border = "double",
			},
			on_open = function(term)
				term:set_mode("n")
				term:persist_mode()

				vim.api.nvim_buf_set_option(term.bufnr, "modifiable", false)
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			on_exit = function()
				specterm = nil
			end,
		})

		return specterm
	end

	vim.keymap.set("n", "]t", function()
		local command = get_command_for_filetype()

		if not command then
			vim.notify("No test command defined for current filetype", vim.log.levels.WARN)
			return
		end

		local term = create_or_get_terminal()

		-- If terminal is already running, send SIGINT (Ctrl+C) before running new command
		if term:is_open() then
			term:send("\x03")
			-- Small delay to ensure the previous command is interrupted
			vim.defer_fn(function()
				term:send(command .. "\n")
			end, 300)
		else
			term:toggle()
			-- Small delay to ensure terminal is ready
			vim.defer_fn(function()
				term:send(command .. "\n")
			end, 50)
		end
	end, { noremap = true, silent = true, desc = "Run specs" })

	vim.keymap.set("n", "[t", function()
		if not specterm then
			return
		end

		specterm:toggle()
	end, { noremap = true, silent = true, desc = "Open Specs" })
end

return M
