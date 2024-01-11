return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")

		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<esc>"] = actions.close,
						["<C-u>"] = false,
					},
				},
				preview = {
					-- filesize_limit = 0.1 -- MB
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
		keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
		keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>")
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
	end,
}
