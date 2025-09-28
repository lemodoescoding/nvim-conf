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

		local telescopeConfig = require("telescope.config")

		-- Clone the default Telescope configuration
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		-- I don't want to search in the `.git` directory.
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				vimgrep_arguments = vimgrep_arguments,
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
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("scope")

		local keymap = vim.keymap

		-- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
		-- keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
		-- keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
		-- keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>")
		-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
	end,
}
