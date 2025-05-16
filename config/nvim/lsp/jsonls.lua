return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	settings = {
		json = {
			-- Enable validation and schema support
			validate = { enable = true },
			-- Optionally add custom schemas here
			schemas = {
				-- Example:
				-- {
				--   fileMatch = { "package.json" },
				--   url = "https://json.schemastore.org/package.json"
				-- }
			},
		},
	},
}
