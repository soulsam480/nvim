vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "Copy to clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>yy", '"+yy', { noremap = true, desc = "Copy line to clipboard" })

vim.keymap.set("n", "<C-c>", "<cmd>:bdelete<CR>", { desc = "Close current buffer" })

vim.keymap.set("n", "<leader>cc", "<cmd>%bd<CR>", { desc = "Close all open buffers" })

vim.keymap.set("n", "<C-u>", "15k", { noremap = true })

vim.keymap.set("n", "<C-d>", "15j", { noremap = true })

vim.keymap.set("n", "gf", function()
	local cfile = vim.fn.expand("<cfile>")

	if vim.bo.filetype == "toggleterm" then
		vim.cmd("ToggleTerm")
	end

	vim.cmd("edit " .. cfile)
end, { desc = "edit file under current cursor" })
