return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dash = require("alpha.themes.theta")

		dash.file_icons.provider = "devicons"

		require("alpha").setup(dash.config)
	end,
}
