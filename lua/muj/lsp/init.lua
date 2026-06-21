return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"SmiteshP/nvim-navic",
	},
	config = function()
		require("muj.lsp.handlers").setup()
	end,
}
