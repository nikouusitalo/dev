return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
		-- Example: ignore unknown at-rules (e.g., for TailwindCSS)
		lint = {
			unknownAtRules = "ignore",
		},
	},
}
