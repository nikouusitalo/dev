return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			lua = { "luacheck" },
			bash = { "shellcheck" },
			go = { "golangcilint" },
			python = { "pylint" },
			haskell = { "hlint" },
			typescript = { "eslint" },
			ts = { "eslint" },
			tsx = { "eslint" },
			c = { "clang_tidy" },
			cpp = { "clang_tidy" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- try_lint without arguments runs the linters defined in `linters_by_ft`
				-- for the current filetype
				require("lint").try_lint()
			end,
		})
	end,
}
