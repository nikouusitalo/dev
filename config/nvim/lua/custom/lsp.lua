-- 1) Completeopt & pum mappings
--    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--      vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--   vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
-- 1) Polku snippet-kansioon
-- 1) Polku snippet-kansioon
vim.o.completeopt = "menu,menuone,noselect"
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/implementation") then
			-- Create a keymap for vim.lsp.buf.implementation ...
			vim.keymap.set(
				"n", -- normal mode
				"gi", -- keybinding
				vim.lsp.buf.implementation, -- LSP implementation jump
				{ buffer = bufnr, desc = "LSP: Go to implementation" }
			)
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method("textDocument/completion") then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
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
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end
	end,
})
local ok, ts = pcall(require, "vim.treesitter")
if ok and ts.start then
	ts.start = function() end
end
vim.diagnostic.config({
	-- update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- 1. Määritellään LSP-konffikansio
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"

-- 2. Haetaan kaikki .lua-tiedostot kyseisestä kansiosta
local files = vim.fn.globpath(lsp_dir, "*.lua", false, true)

-- 3. Otetaan kiekusta talteen pelkät tiedostonimet ilman .lua-päätettä
local servers = {}
for _, path in ipairs(files) do
	local name = vim.fn.fnamemodify(path, ":t:r")
	table.insert(servers, name)
end

-- 4. Käynnistetään kaikki löydetyt LSP-palvelimet
require("vim.lsp").enable(servers)
