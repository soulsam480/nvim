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

local oxlint_config_files = {
	"oxlintrc.json",
	".oxlintrc.json",
}

local eslint_format_files = {
	".eslintformat",
}

local prettier_config_files = {
	".prettierrc",
	".prettierrc.cjs",
}

M.check_files = function(files)
	local cwd = vim.fn.getcwd() -- Get the current working directory

	for _, config_file in ipairs(files) do
		local file_path = cwd .. "/" .. config_file
		if vim.loop.fs_stat(file_path) then
			return config_file
		end
	end

	return nil
end

-- Function to check if any of the ESLint config files exist in the root of the project
M.get_enabled_linter = function()
	if M.check_files(eslint_config_files) then
		return true
	end

	if M.check_files(biome_config_files) then
		return true
	end

	if M.check_files(oxlint_config_files) then
		return true
	end

	return false -- Return false if no ESLint config files are found
end

-- function to check if there's a linter config for provided
M.has_linter = function(linter)
	if linter == "oxlint" then
		return M.check_files(oxlint_config_files)
	end

	if linter == "eslint" then
		return M.check_files(eslint_config_files)
	end

	if linter == "biome" then
		return M.check_files(biome_config_files)
	end

	if linter == "prettier" then
		return M.check_files(prettier_config_files)
	end

	if linter == "eslint-format" then
		return M.check_files(eslint_format_files)
	end
end

return M
