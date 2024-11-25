local M = {}

-- List of ESLint config files to check for
local eslint_config_files = {
	".eslintrc.json",
	".eslintrc.js",
	".eslintrc.yml",
	".eslint.json",
}

local biome_config_files = {
	"biome.json",
	"biome.jsonc",
}

-- Function to check if any of the ESLint config files exist in the root of the project
M.get_enabled_linter = function()
	local cwd = vim.fn.getcwd() -- Get the current working directory

	for _, config_file in ipairs(eslint_config_files) do
		local file_path = cwd .. "/" .. config_file
		if vim.loop.fs_stat(file_path) then
			return "eslint" -- Return true if any ESLint config file is found
		end
	end

	for _, config_file in ipairs(biome_config_files) do
		local file_path = cwd .. "/" .. config_file
		if vim.loop.fs_stat(file_path) then
			return "biome" -- Return true if any ESLint config file is found
		end
	end

	return false -- Return false if no ESLint config files are found
end

return M
