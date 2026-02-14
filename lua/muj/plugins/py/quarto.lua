return {
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "markdown", "quarto", "python" },
		config = function()
			require("quarto").setup({
				lspFeatures = {
					chunks = "all",
					languages = { "r", "python", "rust", "lua" },
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				keymap = {
					hover = "H",
					definition = "gd",
					rename = "<leader>rn",
					references = "gr",
					format = "<leader>gf",
				},
				codeRunner = {
					enabled = true,
					default_method = "molten", -- "molten", "slime", "iron" or <function>
					ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
					-- Takes precedence over `default_method`
					never_run = { "yaml" }, -- filetypes which are never sent to a code runner
				},
			})

			local quarto = require("quarto")

			vim.keymap.set(
				"n",
				"<leader>qp",
				quarto.quartoPreview,
				{ desc = "Preview the Quarto document", silent = true, noremap = true }
			)
			-- to create a cell in insert mode, I have the ` snippet
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>qC",
			-- 	"i```python<c-j><c-j>```<up>",
			-- 	{ desc = "Create a new code cell", silent = true }
			-- )
			vim.keymap.set("n", "<leader>qC", function()
				local lines = { "```python", "", "```" }
				vim.api.nvim_put(lines, "l", true, true)
				vim.cmd("normal! k")
				vim.cmd("startinsert")
			end, { desc = "Create a new code cell", silent = true })

			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>qS",
			-- 	"i```\r\r```python<left>",
			-- 	{ desc = "Split code cell", silent = true, noremap = true }
			-- )
			vim.keymap.set("n", "<leader>qS", function()
				local divider = { "```", "", "```python" }
				vim.api.nvim_put(divider, "l", false, true)
				vim.cmd("normal! jj")
			end, { desc = "Split cell (move current line to new cell)", silent = true })
		end,
	},
}
