local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	keymap(bufnr, "n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		local lspconfig = require("lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_attach = function(client, bufnr)
			-- opts.buffer = bufnr
			--
			-- opts.desc = "Show LSP references", keymap.set("n", "<leader>gR", "<cmd>Telescope lsp_references<CR>", opts)
			--
			-- opts.desc = "Go to declaration", keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
			--
			-- opts.desc = "Show LSP definition"
			-- keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			--
			-- opts.desc = "Show LSP implementation"
			-- keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			--
			-- opts.desc = "Show LSP type definition"
			-- keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
			--
			-- opts.desc = "See available code actions"
			-- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
			--
			-- opts.desc = "Smart rename"
			-- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			--
			-- opts.desc = "Show buffer diagnostics"
			-- keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			--
			-- opts.desc = "Show line diagnostics"
			-- keymap.set("n", "<leader>d", vim.diagnostics.open_float, opts)
			--
			-- opts.desc = "Go to Previous diagnostics"
			-- keymap.set("n", "[d", vim.diagnostics.goto_prev, opts)
			--
			-- opts.desc = "Go to Next diagnostics"
			-- keymap.set("n", "]d", vim.diagnostics.goto_next, opts)
			--
			-- opts.desc = "Show documentation"
			-- keymap.set("n", "K", vim.lsp.buf.hover, opts)
			--
			-- opts.desc = "Restart LSP"
			-- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			if client.name == "tsserver" then
				client.server_capabilities.documentFormattingProvider = false
			end

			if client.name == "sumneko_lua" then
				client.server_capabilities.documentFormattingProvider = false
			end

			lsp_keymaps(bufnr)
		end

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = {

			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
		}

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end
		-- lsp language configuration --

		lspconfig["html"].setup({
			capabilites = capabilities,
			on_attach = on_attach,
		})

		lspconfig["tsserver"].setup({
			capabilites = capabilities,
			on_attach = on_attach,
		})

		lspconfig["cssls"].setup({
			capabilites = capabilities,
			on_attach = on_attach,
		})

		lspconfig["emmet_ls"].setup({
			capabilites = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		lspconfig["pyright"].setup({
			capabilites = capabilities,
			on_attach = on_attach,
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["svelte"].setup({
			capabilities = capabilities,
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
	end,
}
