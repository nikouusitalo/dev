return {
	cmd = { "matlab-language-server", "--stdio" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	filetypes = { "matlab" },
	root_dir = function(bufnr, on_dir)
		local root_dir = vim.fs.root(bufnr, ".git")
		on_dir(root_dir or vim.fn.getcwd())
	end,
	settings = {
		MATLAB = {
			indexWorkspace = true,
			installPath = "/usr/local/MATLAB/R2024b",
			matlabConnectionTiming = "onStart",
			telemetry = false,
		},
	},
}
