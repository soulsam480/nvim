local M = {}

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

return M
