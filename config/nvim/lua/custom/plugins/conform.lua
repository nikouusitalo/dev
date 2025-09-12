return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = { "isort", "black" },
				lua = { "stylua" },
				go = { "gofmt" },
				haskell = { "ormolu" },
				c = { "clang_format" },
				cpp = { "clang_format" },
			},
		})
	end,
}
