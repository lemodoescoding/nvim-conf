vim.g.mapleader = " " -- set vim's mapleader key to <Space>

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
			title = true,
			title_pos = "center",
			border = "rounded",
		},

		layout = {
			width = { min = 20 },
			spacing = 3,
		},

		keys = {
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		},

		-- show_help = true,
		-- plugins = {
		-- 	marks = true,
		-- 	registers = true,
		-- 	spelling = {
		-- 		enabled = true,
		-- 		suggestions = 20,
		-- 	},
		--
		-- 	presets = {
		-- 		operators = false,
		-- 		motions = true,
		-- 		text_objects = true,
		-- 		windows = true,
		-- 		nav = true,
		-- 		z = true,
		-- 		g = true,
		-- 	},
		-- },
		--
		-- icons = {
		-- 	breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		-- 	separator = "➜", -- symbol used between a key and it's label
		-- 	group = "+", -- symbol prepended to a group
		-- },
		--
		-- -- sorting keymap based on alpha-numerical order -- added from v3 config example on github
		-- sort = { "alphanum" },
		--
		-- -- change from popup_mapping to keys due to new v3 config standard
		-- keys = {
		-- 	scroll_down = "<c-j>", -- binding to scroll down inside the popup
		-- 	scroll_up = "<c-k>", -- binding to scroll up inside the popup
		-- },
		--
		-- -- change these settings to newer v3 config
		-- win = {
		-- 	title_pos = "center",
		-- 	width = 1,
		-- 	height = { min = 4, max = 25 },
		-- 	border = "rounded",
		-- 	padding = { 2, 2 },
		-- },
		--
		-- -- layout of the popup
		-- layout = {
		-- 	height = { min = 4, max = 25 }, -- min and max height of the
		-- 	width = { min = 20, max = 50 },
		-- 	spacing = 3,
		-- 	align = "left",
		-- },
		--
		-- show_keys = true, -- show the currently pressed key
		-- show_help = true,

		-- removed triggers_backlist, hidden, ignore_options opts
		-- modify triggers option based on the new v3 standard
		-- triggers = {
		-- 	{ "<auto>", mode = "nxso" },
		-- 	{ "<leader>", mode = { "n", "v" } },
		-- },
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
		{ "<leader>wr", "<cmd>SessionRestore<CR>", desc = "Restore Session On CWD" },
	},
}
