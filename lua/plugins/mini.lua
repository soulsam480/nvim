return {
	{
		"echasnovski/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = "*",
		cofig = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.diff",
		version = "*",
		config = function()
			require("mini.diff").setup({
				view = {
					style = "number",
				},
			})
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = "*",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		version = "*",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"echasnovski/mini.tabline",
		version = "*",
		config = function()
			require("mini.tabline").setup()
		end,
	},
}
