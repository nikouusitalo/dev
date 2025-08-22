vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/implementation") then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		if
			not client:supports_method("textDocument/willSaveWaitUntil")
			and client:supports_method("textDocument/formatting")
		then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
				buffer = args.buf,
				callback = function()
					require("conform").format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
	end,
})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
vim.lsp.config("*", {
	capabilities = vim.tbl_deep_extend("force", capabilities, {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	}),
	root_markers = { ".git" },
})
local config_path = vim.fn.stdpath("config") .. "/lsp"

if vim.fn.isdirectory(config_path) ~= 1 then
	return
end
local files = vim.fn.readdir(config_path)

for _, fname in ipairs(files) do
	if fname:match("%.lua$") then
		local srv = fname:sub(1, -5) -- esim. "gopls"

		local cfg_path = config_path .. "/" .. fname
		local ok, cfg = pcall(dofile, cfg_path)
		if not ok then
			vim.notify("LSP-config-virhe tiedostossa: " .. cfg_path, vim.log.levels.WARN)
			cfg = nil
		end

		if type(cfg) == "table" then
			vim.lsp.config(srv, cfg)
		end

		vim.lsp.enable(srv)
	end
end
