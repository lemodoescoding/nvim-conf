return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesitter-context").setup({
			enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		})

		vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2c3043" })
		vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#ffda7b", bg = "#2c3043" })

		vim.keymap.set("n", "<leader>tj", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { silent = true, desc = "Jump up to function header" })

		-- Toggle context if it's blocking your view
		vim.keymap.set("n", "<leader>tg", ":TSContext toggle<CR>", { desc = "Toggle Treesitter Context" })
	end,
}
