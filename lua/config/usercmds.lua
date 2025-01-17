vim.api.nvim_create_user_command("CopyRelPath", function()
	vim.api.nvim_call_function("setreg", { "+", vim.fn.fnamemodify(vim.fn.expand("%"), ":.") })
end, {
	desc = "Copy relative path of active buffer",
})


vim.api.nvim_create_user_command("CopyFile", function()
		local file_path = vim.fn.expand("%:p")
		local file_contents = vim.fn.readfile(file_path)
		local contents = table.concat(file_contents, "\n")

		vim.api.nvim_call_function("setreg", { "+", contents })
	end,
	{ desc = "Copy contents of current buffer to clipboard" }
)
