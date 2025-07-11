local M = {}

local tailwind_config_files = {
	"tailwind.config.js",
	"tailwind.config.cjs",
	"tailwind.config.mjs",
}

M.get_v4_config = function()
	local root = vim.fn.getcwd()

	local package_json_path = root .. "/tailwind.json"
	local file = io.open(package_json_path, "r")

	if not file then
		return nil
	end

	local content = file:read("*a")
	file:close()

	local conf = vim.json.decode(content)

	if not conf then
		return nil
	end

	return conf["config_file"]
end

M.has_tailwind_v4 = function()
	local root = vim.fn.getcwd() -- Get the current working directory

	if not root then
		return false
	end

	local package_json_path = root .. "/package.json"
	local file = io.open(package_json_path, "r")
	if not file then
		return false
	end

	local content = file:read("*a")
	file:close()

	local dependencies = vim.json.decode(content)
	if not dependencies then
		return false
	end

	local deps = dependencies.dependencies or {}
	local dev_deps = dependencies.devDependencies or {}

	return deps["@tailwindcss/vite"] ~= nil or dev_deps["@tailwindcss/vite"] ~= nil
end

M.get_tailwind_config_file = function()
	if M.has_tailwind_v4() then
		return M.get_v4_config() or "css/styles.css"
	end

	return require("utils.linter").check_files(tailwind_config_files)
end

return M
