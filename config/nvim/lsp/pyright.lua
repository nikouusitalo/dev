---@type vim.lsp.Config
return {
	cmd = { "pyright-langserver", "--stdio" },
	oot_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace", -- tai "openFilesOnly"
				typeCheckingMode = "basic", -- "off" | "basic" | "strict"
				useLibraryCodeForTypes = true,
			},
		},
	},
}
