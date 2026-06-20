return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
		local event = "BufWritePre"
		local async = event == "BufWritePost"

		local prettier_with_tabs = function(opts)
			return null_ls.builtins.formatting.prettier.with(vim.tbl_extend("force", {
				extra_args = { "--tab-width", "4", "--use-tabs" },
			}, opts or {}))
		end

		null_ls.setup({
			-- root_dir = require("null-ls.utils").root_pattern(".git", "go.mod", "package.json", "."),
			sources = {
				null_ls.builtins.formatting.stylua,

				-- PHP + Blade
				prettier_with_tabs({
					filetypes = { "php" },
					extra_args = { "--tab-width", "4", "--use-tabs", "--parser", "php" },
					extra_filetypes = { "blade" },
				}),

				-- HTML
				prettier_with_tabs({ filetypes = { "html", "htm" } }),

				-- CSS, SCSS, Less
				prettier_with_tabs({ filetypes = { "css", "scss", "less" } }),

				-- JavaScript, TypeScript, JSX, TSX
				prettier_with_tabs({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"jsx",
						"tsx",
					},
				}),

				-- JSON
				prettier_with_tabs({ filetypes = { "json", "jsonc" } }),

				-- Markdown
				prettier_with_tabs({ filetypes = { "markdown", "md" } }),

				-- YAML
				prettier_with_tabs({ filetypes = { "yaml", "yml" } }),

				null_ls.builtins.formatting.clang_format.with({
					extra_args = {
						"-style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Always, TabWidth: 4, SortIncludes: false}",
						-- "-style={BasedOnStyle: LLVM, SortIncludes: false}", -- changes the formatting style to LLVM (there is still many other)
						-- '"{UseTab: Always, IndentWith: 4, TabWidth: 4}"',
					},
				}),
				null_ls.builtins.formatting.black.with({
					extra_args = { "--line-length=125" },
				}),
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.jq,
				null_ls.builtins.formatting["goimports"],

				-- GO Formatter
				null_ls.builtins.formatting.gofumpt,
				-- null_ls.builtins.formatting.gci.with({
				-- 	-- GCI requires sections to be defined to work effectively
				-- 	extra_args = { "--sections", "standard,default" },
				-- }),

				-- NGINX
				null_ls.builtins.formatting.nginx,
			},

			-- make auto-format on save (async)

			on_attach = function(client, bufnr)
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					-- vim.api.nvim_create_autocmd("BufWritePre", {
					-- 	group = augroup,
					-- 	buffer = bufnr,
					-- 	callback = function()
					-- 		vim.lsp.buf.format({
					-- 			bufnr = bufnr,
					-- 			filter = function(c)
					-- 				-- ONLY use null-ls for formatting
					-- 				return c.name == "null-ls"
					-- 			end,
					-- 			timeout_ms = 3000,
					-- 		})
					-- 	end,
					-- callback = function()
					-- 	vim.lsp.buf.format({ async = false })
					-- end,
					-- })
				end
			end,
		})

		vim.keymap.set("n", "<leader>gf", function()
			vim.lsp.buf.format({
				async = false,
				filter = function(client)
					return client.name == "null-ls"
				end,
				timeout_ms = 3000,
			})
		end, { desc = "Force format", silent = true })
	end,
}
