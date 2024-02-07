return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local nvimtree = require("nvim-tree")
		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

		-- configure nvim-tree
		nvimtree.setup({
			view = {
				width = 35,
			},
			-- change folder arrow icons
			renderer = {
				full_name = true,
				group_empty = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},

			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
		})

		-- nvim-tree custom keymap
		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")
		keymap.set("n", "<leader>ef", ":NvimTreeFocus<CR>")
		keymap.set("n", "<leader>ex", ":NvimTreeClose<CR>")
	end,
}
