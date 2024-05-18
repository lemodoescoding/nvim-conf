return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local event = "BufWritePre"
		local async = event == "BufWritePost"

		null_ls.setup({
			sources = {
				-- require("none-ls.diagnostics.eslint"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				-- null_ls.builtins.formatting.phpcsfixer,
				null_ls.builtins.formatting.phpcbf,
				-- null_ls.builtins.diagnostics.eslint_d,
			},

			-- make auto-format on save (async)
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})

		-- format shortcut keymap
		-- vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
