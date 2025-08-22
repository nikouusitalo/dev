return {
	"mason-org/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"jay-babu/mason-null-ls.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-tool-installer").setup({
			ensure_installed = {
				--lsp
				"clangd",
				"pyright",
				"bash-language-server",
				"gopls",
				"lua-language-server",
				"rust-analyzer",
				"mutt-language-server",
				"matlab-language-server",
				"marksman",
				"haskell-language-server",
				"docker-compose-language-service",
				"dockerfile-language-server",
				"css-lsp",
				"cmake-language-server",
				"sqls",
				"typescript-language-server",
				--dap
				"bash-debug-adapter",
				"go-debug-adapter",
				"debugpy",
				--lint
				"luacheck",
				"pylint",
				"shellcheck",
				"golangci-lint",
				"hlint",
				--formating
				"shfmt",
				"stylua",
				"ormolu",
				"clang-format",
			},
			auto_update = true,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = nil, -- ← disable the 5-hour lockout
			integrations = {
				["mason-lspconfig"] = true,
				["mason-null-ls"] = true,
				["mason-nvim-dap"] = true,
			},
		})

		-- register your User‐event handler *after* setup
		local aug = vim.api.nvim_create_augroup("MasonToolsMessages", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			group = aug,
			pattern = "MasonToolsStartingInstall",
			callback = function()
				vim.schedule(function()
					vim.notify("🚀 mason-tool-installer is starting…", vim.log.levels.INFO)
				end)
			end,
		})
	end,
}
