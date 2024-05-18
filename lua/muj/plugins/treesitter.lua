return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		treesitter.setup({
			ensure_installed = {
				"c",
				"cpp",
				"css",
				"dockerfile",
				"gitcommit",
				"gitignore",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"php",
				"sql",
				"tsx",
				"typescript",
			},

			highlight = {
				-- enable = true,
				additional_vim_regex_highlighting = false,
			},

			autotag = { enable = true },

			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>", -- set to `false` to disable one of the mappings
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
