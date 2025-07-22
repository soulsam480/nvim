local function get_bime_binary()
	local cwd = vim.fn.getcwd() -- Get the current working directory

	return cwd .. "/" .. "node_modules/.bin/biome"
end

local function find_biome_config()
	local cwd = vim.fn.getcwd()

	local config_path = cwd .. "/biome.jsonc"

	-- Check if biome.jsonc exists and is readable in the current working directory
	if vim.fn.filereadable(config_path) == 1 then
		return config_path
	end

	return nil
end

vim.api.nvim_create_user_command("BiomeFixAll", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)

	if bufname == "" then
		vim.notify("Buffer has no file name!", vim.log.levels.ERROR)
		return
	end

	-- Save the current buffer to ensure changes aren't lost
	vim.cmd("write")

	local biome_cmd = { get_bime_binary(), "lint", "--write", "--unsafe" }

	-- Add --config flag if biome.jsonc is found
	local config_file = find_biome_config()
	if config_file then
		table.insert(biome_cmd, "--config-path")
		table.insert(biome_cmd, config_file)
	end

	vim.notify(vim.inspect(biome_cmd), vim.log.levels.INFO)

	table.insert(biome_cmd, bufname) -- Always add the buffer name as the last argument

	-- Run Biome CLI
	vim.fn.jobstart(biome_cmd, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stderr = function(_, data)
			if data and #data > 0 then
				vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
			end
		end,
		on_exit = function(_, code)
			if code == 0 then
				-- Reload the buffer to reflect Biome fixes
				vim.cmd("edit!")
				vim.notify("Biome auto-fixes applied!", vim.log.levels.INFO)
			else
				vim.notify("Biome failed to fix issues. Check logs.", vim.log.levels.ERROR)
			end
		end,
	})
end, { desc = "Fix all auto-fixable issues in the current buffer using Biome CLI" })
