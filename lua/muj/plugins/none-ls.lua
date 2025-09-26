return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim", "MunifTanjim/prettier.nvim" },
	config = function()
		local null_ls = require("null-ls")

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
		local event = "BufWritePre"
		local async = event == "BufWritePost"

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.eslint"),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd.with({
					extra_args = { "--arrow-parens", "avoid" },
				}),
				null_ls.builtins.formatting.clang_format.with({
					extra_args = {
						"-style={BasedOnStyle: LLVM, SortIncludes: false}", -- changes the formatting style to LLVM (there is still many other)
						-- '"{UseTab: Always, IndentWith: 4, TabWidth: 4}"',
					},
				}),
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length=125" },
				}),
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.jq,
				-- null_ls.builtins.formatting.phpcsfixer,
				-- null_ls.builtins.formattin.phpcb,
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
