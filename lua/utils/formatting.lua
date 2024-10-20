
local M = {}

local function format(buf)
	require("conform").format({ bufnr = buf })
end

M.format = format

return M
