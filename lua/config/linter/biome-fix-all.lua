local function get_bime_binary()
	local cwd = vim.fn.getcwd() -- Get the current working directory

	return cwd .. "/" .. "node_modules/.bin/biome"
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

	local biome_cmd = { get_bime_binary(), "lint", "--write", "--unsafe", bufname }

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
