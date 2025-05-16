---@type vim.lsp.Config
return {
	cmd = { "gopls" },
	root_markers = { "go.work", "go.mod", ".git" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	on_attach = function(client, bufnr)
		-- ota LSP-omnifunc käyttöön
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	end,
}
