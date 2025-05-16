return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim", "jay-babu/mason-nvim-dap.nvim" },

		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"typescript-language-server",
					"lua-language-server",
					"clangd",
					"stylua",
					"matlab-language-server",
					"pyright",
					"bashls",
					"marksman",
					"gopls",
					"cssls",
					"jsonls",
				},
				run_on_start = true,
				start_delay = 3000,
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},
}
