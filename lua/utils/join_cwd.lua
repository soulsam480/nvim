local M = {}

M.join = function(path)
	local cwd = vim.fn.getcwd()

	return vim.fn.fnamemodify(cwd .. "/" .. path, ":p")
end

return M
