vim.g.mapleader = " " -- set vim's mapleader key to <Space>
vim.o.timeout = true
vim.o.timeoutlen = 100 -- set timeoutlen to reduce delay

-- TODO: update this which-key configuration to v3
-- -Tree

return {
	"folke/which-key.nvim",
	dependencies = {
		"echasnovski/mini.nvim",
	},
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 500,

		win = {
			no_overlap = true,
			padding = { 1, 2 },
			title = " Keymaps ",
			title_pos = "center",
			border = "rounded",
		},

		layout = {
			width = { min = 20 },
			spacing = 3,
		},

		-- change from popup_mapping to keys due to new v3 config standard
		keys = {
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		},

		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		--
		-- sorting keymap based on alpha-numerical order -- added from v3 config example on github
		sort = { "alphanum" },
	},

	keys = {
		{ "<leader>a", "<cmd>:Alpha<cr>", desc = "Home Buffer" },

		-- Neo-tree section
		{ "<leader>e", "Neo-Tree" },
		{ "<leader>ec", "<cmd>Neotree close<CR>", desc = "Close Explorer" },
		{ "<leader>ef", "<cmd>Neotree focus<CR>", desc = "Focus Explorer" },
		{ "<leader>et", "<cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },

		-- Telescope section
		{ "<leader>f", "Telescope" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },

		-- Live-server section
		{ "<leader>s", "Live-Server H,C,J" },
		{ "<leader>st", "<cmd>LiveServerStop<CR>", desc = "Stop Live Server" },
		{ "<leader>ss", "<cmd>LiveServerStart<CR>", desc = "Start Live Server" },

		-- Transparent BG
		{ "<leader>t", "Transparent Bg" },
		{ "<leader>tt", "<cmd>TransparentToggle<CR>", desc = "Toggle Transparent Bg" },

		-- Session Section
		{ "<leader>w", "Session" },
		{ "<leader>wd", "<cmd>Autosession delete<CR>", desc = "Delete Selected Session" },
		{ "<leader>we", "<cmd>Autosession search<CR>", desc = "Search Sessions" },
		{ "<leader>ws", "<cmd>SessionSave<CR>", desc = "Save Current Session" },
		{ "<leader>wr", "<cmd>Autosession restore<CR>", desc = "Restore Session On CWD" },

		-- Common purpose shortcut
		{ "<leader>qq", "<cmd>:wqa<CR>", desc = "Quit all and save current buffer" },
		{ "<leader>qf", "<cmd>:qa!<CR>", desc = "Quit all and don't save" },
		{ "<leader>qw", "<cmd>:qw<CR>", desc = "Quit and save current buffer" },
		{ "<leader>wb", "<cmd>:w<CR>", desc = "Save current buffer" },

		{ "<leader>to", ":tabnew<CR>", desc = "Open new tab" }, -- new
		{ "<leader>tx", ":tabclose<CR>", desc = "Close current tab" }, -- close
		{ "<leader>tn", ":tabn<CR>", desc = "Switch to next tab" }, -- next
		{ "<leader>tp", ":tabp<CR>", desc = "Switch t previous tab" }, -- prev

		{ "<leader>sv", "<C-w>v", desc = "Split current buffer vertically" }, -- vertical
		{ "<leader>sh", "<C-w>s", desc = "Split current buffer horizontally" }, -- horizontal
		{ "<leader>se", "<C-w>=", desc = "Split current buffer into equally size" }, -- split equally
		{ "<leader>sx", "<cmd>:close<CR>", desc = "Close current splitted buffer" }, -- close current split
		{ "<leader>sm", "<cmd>:MaximizerToggle<CR>", desc = "Maximize and toggle current selected split" },

		{ "<leader>tb", ":split term://zsh<CR>", desc = "Open up a terminal (ZSH) on horizontal split" },
		{ "<leader>tv", ":vsplit term://zsh<CR>", desc = "Open up a terminal (ZSH) on vertical split" },
	},
}
