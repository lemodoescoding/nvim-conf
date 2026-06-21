local M = {}

M.setup = function()
	-- Diagnostics
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.HINT] = "",
				[vim.diagnostic.severity.INFO] = "",
			},
		},
		virtual_text = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			border = "rounded",
			source = true,
		},
	})

	-- Capabilities
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- on_attach
	local on_attach = function(client, bufnr)
		-- let none-ls handle formatting
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end

		local opts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			vim.tbl_extend("force", opts, { desc = "Go to Declaration" })
		)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
		vim.keymap.set("n", "gK", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Docs" }))
		vim.keymap.set(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("force", opts, { desc = "Go to Implementation" })
		)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
		vim.keymap.set(
			"n",
			"gl",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, { desc = "Line Diagnostics" })
		)
		vim.keymap.set(
			"n",
			"gt",
			vim.lsp.buf.type_definition,
			vim.tbl_extend("force", opts, { desc = "Type Definition" })
		)
		vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", vim.tbl_extend("force", opts, { desc = "LSP Info" }))
		vim.keymap.set(
			"n",
			"<leader>lj",
			vim.diagnostic.goto_next,
			vim.tbl_extend("force", opts, { desc = "Next Diagnostic" })
		)
		vim.keymap.set(
			"n",
			"<leader>lk",
			vim.diagnostic.goto_prev,
			vim.tbl_extend("force", opts, { desc = "Prev Diagnostic" })
		)
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
		vim.keymap.set(
			"n",
			"<leader>ls",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("force", opts, { desc = "Signature Help" })
		)
		vim.keymap.set(
			"n",
			"<leader>lq",
			vim.diagnostic.setloclist,
			vim.tbl_extend("force", opts, { desc = "Quickfix Diagnostics" })
		)
		vim.keymap.set(
			"n",
			"<leader>rs",
			"<cmd>LspRestart<CR>",
			vim.tbl_extend("force", opts, { desc = "Restart LSP" })
		)
	end

	-- Default config for ALL servers
	vim.lsp.config("*", {
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- Per-server overrides

	vim.lsp.config("clangd", {
		on_attach = function(client, bufnr)
			client.server_capabilities.signatureHelpProvider = false
			on_attach(client, bufnr)
		end,
	})

	vim.lsp.config("prismals", {
		on_attach = function(client, bufnr)
			client.server_capabilities.signatureHelpProvider = false
			on_attach(client, bufnr)
		end,
	})

	vim.lsp.config("intelephense", {
		root_dir = function()
			return vim.uv.cwd()
		end,
	})

	vim.lsp.config("emmet_ls", {
		filetypes = {
			"html",
			"htm",
			"css",
			"scss",
			"less",
			"sass",
			"javascriptreact",
			"typescriptreact",
			"svelte",
		},
	})

	vim.lsp.config("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	vim.lsp.config("svelte", {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.js", "*.ts" },
				callback = function(ctx)
					if client.name == "svelte" then
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
					end
				end,
			})
		end,
	})

	vim.lsp.config("pyright", {
		settings = {
			python = {
				analysis = {
					diagnosticMode = "openFilesOnly",
					diagnosticSeverityOverrides = {
						reportUnusedExpression = "none",
					},
				},
			},
		},
	})

	vim.lsp.config("gopls", {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_markers = { "go.work", "go.mod" },
		root_dir = vim.fs.root(0, { "go.work", "go.mod" }), -- remove .git
		settings = {
			gopls = {
				gofumpt = false,
				usePlaceholders = true,
				staticcheck = true,
				analyses = {
					unusedparams = true,
					unreachable = true,
				},
				codelenses = {
					generate = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					run_govulncheck = false,
				},
				hints = {
					parameterNames = true,
					constantValues = true,
					rangeVariableTypes = true,
					compositeLiteralFields = true,
				},
			},
		},
	})

	vim.lsp.config("vtsls", {
		root_dir = vim.fs.root(0, { "jsconfig.json", "tsconfig.json", "package.json", ".git" }),
		settings = {
			javascript = {
				preferGoToSourceDefinition = true,
				validate = { enable = false },
				suggestionActions = { enabled = false },
				format = { enable = false },
			},
			typescript = { preferGoToSourceDefinition = true },
			vtsls = {
				autoUseWorkspaceTsdk = true,
				-- experimental = {
				-- 	completion = { enableServerSideFuzzyMatch = true },
				-- },
				experimental = {
					maxInlayHintLength = 0, -- disable inlay hints, reduces work
				},
			},
		},
	})

	-- Enable servers
	vim.lsp.enable({
		"vtsls",
		"emmet_ls",
		"lua_ls",
		"html",
		"cssls",
		"bashls",
		"jsonls",
		"yamlls",
		"svelte",
		"intelephense",
		"clangd",
		"prismals",
		"pyright",
		"gopls",
		"jdtls",
		"nginx_language_server",
	})
end

return M
