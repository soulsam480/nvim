local M = {}

local function format(buf)
	require("conform").format({
		bufnr = buf,
		lsp_fallback = true,
	})
end

M.format = format

return M
