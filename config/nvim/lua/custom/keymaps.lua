vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "Lsp: " .. desc })
		end
		map("<leader>ww", vim.lsp.buf.workspace_symbol, "workspace_symbol")
		map("<leader>rn", vim.lsp.buf.rename, "rename")
		map("<leader>ca", vim.lsp.buf.code_action, "code action")
		map("<leader>wf", vim.lsp.buf.format, "format")
		map("K", vim.lsp.buf.hover, "hover")
		map("<leader>n", vim.diagnostic.open_float, "diagnostic")
		map("<leader>k", vim.lsp.buf.signature_help, "sig help")
		map("ö", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "diagnostic prev")

		map("ä", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "diagnostic next")
	end,
})
