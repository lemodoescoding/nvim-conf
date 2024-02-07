local servers = {
	"lua_ls",
	"tsserver",
	"html",
	"cssls",
	"bashls",
	"jsonls",
	"yamlls",
	"svelte",
}

local settings = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		require("mason").setup(settings)
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
		if not lspconfig_status_ok then
			return
		end

		local opts = {}

		for _, server in pairs(servers) do
			opts = {
				on_attach = require("muj.lsp.handlers").on_attach(),
				capabilities = require("muj.lsp.handlers").capabilities,
			}

			server = vim.split(server, "@")[1]

			local require_ok, conf_opts = pcall(require, "lsp.settings." .. server)
			if require_ok then
				opts = vim.tbl_deep_extend("keep", conf_opts, opts)
			end

			lspconfig[server].setup(opts)
		end
	end,
}
