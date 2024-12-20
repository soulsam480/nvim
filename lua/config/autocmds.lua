vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype == "BufTerm" or vim.bo.buftype == "terminal" then
			local is_floating = vim.api.nvim_win_get_config(0).relative ~= ""
			if is_floating then
				vim.opt_local.number = false
				vim.opt_local.relativenumber = false
				-- vim.opt.listchars = {}
			end
		end
	end,
})
