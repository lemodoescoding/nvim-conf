return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local startify = require("alpha.themes.startify")

		startify.section.header.val = {
			[[                                   __                ]],
			[[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}

		startify.section.top_buttons.val = {
			startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			startify.button("f", "󰱼  Find File", "<cmd>Telescope find_files<CR>"),
			startify.button("r", "󰁯  Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			startify.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
		}

		startify.section.bottom_buttons.val = {}

		startify.section.footer.val = {
			{ type = "text", val = "github.com/lemodoescoding" },
		}

		-- Send config to alpha
		alpha.setup(startify.config)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
		vim.cmd([[autocmd User AlphaReady set showtabline=0]])
		vim.cmd([[autocmd BufUnload <buffer> set showtabline=2]])
	end,
}
