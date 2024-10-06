return {

	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({

			sections = {
				lualine_a = {
					{
						"datetime",
						style = "%d-%m-%Y %I:%M:%S %p",
						icon = "🕒",
					},
				},
			},
		})
	end,
}
