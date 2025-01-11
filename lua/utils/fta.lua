-- lua/fta-score/init.lua
local M = {}

-- Cache to store FTA scores
M.stats = {}

-- Debounce timer
local timer = nil

-- Supported file types
local supported_filetypes = {
	javascript = true,
	typescript = true,
	javascriptreact = true,
	typescriptreact = true,
}

-- Function to run fta-cli and get the score
-- Function to run fta-cli and get the score
local function get_fta_score(file_path)
	-- Don't process empty or invalid file paths
	if not file_path or file_path == "" then
		return nil
	end

	-- Run bunx fta-cli and capture output
	local cmd = string.format('bunx fta-cli --json "%s" 2>/dev/null', file_path)
	local handle = io.popen(cmd)

	if not handle then
		return nil
	end

	-- Use pcall to safely read from handle
	local success, output = pcall(function()
		local result = handle:read("*a")
		handle:close()
		return result
	end)

	-- If reading failed, ensure handle is closed and return nil
	if not success then
		pcall(handle.close, handle)
		return nil
	end

	-- Parse JSON output with error handling
	local parse_success, parsed = pcall(vim.json.decode, output)

	if not parse_success or not parsed then
		return nil
	end

	return parsed[1]
end

-- Function to get current buffer file path
local function get_current_file()
	local file_path = vim.fn.expand("%:p")
	-- Check if it's a real file
	if vim.fn.filereadable(file_path) == 0 then
		return nil
	end
	return file_path
end

-- Function to update FTA score for current buffer
function M.update_score()
	local file_path = get_current_file()
	local file_type = vim.bo.filetype

	-- Only process supported file types and valid files
	if not file_path or not supported_filetypes[file_type] then
		return
	end

	-- Cancel existing timer if any
	if timer then
		timer:stop()
		timer:close()
	end

	-- Create new timer with 10ms delay
	timer = vim.loop.new_timer()
	timer:start(
		10,
		0,
		vim.schedule_wrap(function()
			-- Get and cache the score
			M.stats[file_path] = get_fta_score(file_path)
			-- Force lualine update
			vim.cmd("redrawstatus")
		end)
	)
end

-- Lualine component
function M.get_lualine_component()
	return function()
		local file_type = vim.bo.filetype

		if not supported_filetypes[file_type] then
			return "FTA: N/A"
		end

		local file_path = get_current_file()

		if not file_path then
			return "FTA: No File"
		end

		local score = M.stats[file_path]

		if score then
			return string.format("FTA: %.2f", score.fta_score)
		elseif M.stats[file_path] == nil then
			return "FTA: calculating..."
		else
			return "FTA: N/A"
		end
	end
end

-- Setup function
function M.setup()
	-- Create autocmd group
	local group = vim.api.nvim_create_augroup("FTAScore", { clear = true })

	-- Add autocommands for JavaScript/TypeScript files
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWritePost", "InsertLeave" }, {
		pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
		callback = M.update_score,
		group = group,
	})

	vim.api.nvim_create_user_command("FtaOpen", function()
		local file_path = get_current_file()

		if not file_path then
			return "FTA: No File"
		end

		local score = M.stats[file_path]

		require("utils.float_with_json").create_float_with_json(score)
	end, { desc = "Show FTA results for the current file" })
end

return M
