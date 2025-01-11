local M = {}

M.create_float_with_json = function(json)
	-- Calculate window size
	local width = math.min(120, vim.o.columns - 4)
	local height = math.min(30, vim.o.lines - 4)

	-- Calculate starting position (centered)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create the buffer
	local buf = vim.api.nvim_create_buf(false, true)

	-- Set buffer options
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
	vim.api.nvim_buf_set_option(buf, "filetype", "json")

	-- Window options
	local opts = {
		style = "minimal",
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
	}

	-- Create the window
	local win = vim.api.nvim_open_win(buf, true, opts)

	-- Set window options
	vim.api.nvim_win_set_option(win, "wrap", false)
	vim.api.nvim_win_set_option(win, "cursorline", true)

	-- Format the JSON string using `jq`
	local handle = io.popen("echo '" .. vim.json.encode(json) .. "' | jq '.'")

	if not handle then
		return
	end

	local formatted_json = handle:read("*a")

	handle:close()

	-- Insert the formatted JSON into the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(formatted_json, "\n"))
	vim.api.nvim_win_set_option(win, "modifiable", false)

	-- Add keybinding to close the window
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", {
		noremap = true,
		silent = true,
	})

	return buf, win
end

return M
