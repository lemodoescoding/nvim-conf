local servers = {
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
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
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
	end,
}
