return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons", "rubiin/fortune.nvim" },
	config = function()
		local alpha = require("alpha")
		local startify = require("alpha.themes.startify")

		startify.section.header.val = {
			[[ _____________________________________________________________        ]],
			[[  _____________________________________________________________       ]],
			[[   ____________________________________/\\\_____________________      ]],
			[[    ______________________/\\\____/\\\_\///_____/\\\\\__/\\\\\___     ]],
			[[     _____________________\//\\\__/\\\___/\\\__/\\\///\\\\\///\\\_    ]],
			[[      ______________________\//\\\/\\\___\/\\\_\/\\\_\//\\\__\/\\\_   ]],
			[[       _______________________\//\\\\\____\/\\\_\/\\\__\/\\\__\/\\\_  ]],
			[[        ________________________\//\\\_____\/\\\_\/\\\__\/\\\__\/\\\_ ]],
			[[         _________________________\///______\///__\///___\///___\///__]],
		}

		-- [[_________________oo____oo____oo_oooo_ooo_____ooo_]],
		-- [[oo_ooo___ooooo___oo____oo____oo__oo__oooo___oooo_]],
		-- [[ooo___o_oo___oo_oooo___oo____oo__oo__oo_oo_oo_oo_]],
		-- [[oo____o_oo___oo__oo_____oo__oo___oo__oo__ooo__oo_]],
		-- [[oo____o_oo___oo__oo__o___oooo____oo__oo_______oo_]],
		-- [[oo____o__ooooo____ooo_____oo____oooo_oo_______oo_]],
		-- [[_________________________________________________ ]],

		-- [[                      █████    █████   █████ █████ ██████   ██████]],
		-- [[                     ░░███    ░░███   ░░███ ░░███ ░░██████ ██████]],
		-- [[ ████████    ██████  ███████   ░███    ░███  ░███  ░███░█████░███]],
		-- [[░░███░░███  ███░░███░░░███░    ░███    ░███  ░███  ░███░░███ ░███]],
		-- [[ ░███ ░███ ░███ ░███  ░███     ░░███   ███   ░███  ░███ ░░░  ░███]],
		-- [[ ░███ ░███ ░███ ░███  ░███ ███  ░░░█████░    ░███  ░███      ░███]],
		-- [[ ████ █████░░██████   ░░█████     ░░███      █████ █████     █████]],
		-- [[░░░░ ░░░░░  ░░░░░░     ░░░░░       ░░░      ░░░░░ ░░░░░     ░░░░░]],

		-- [[____________________________________________/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_]],
		-- [[ ___________________________________________\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_]],
		-- [[  _________________________________/\\\______\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_]],
		-- [[   __/\\/\\\\\\_______/\\\\\_____/\\\\\\\\\\\__\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_]],
		-- [[    _\/\\\////\\\____/\\\///\\\__\////\\\////____\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_]],
		-- [[     _\/\\\__\//\\\__/\\\__\//\\\____\/\\\_________\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_]],
		-- [[      _\/\\\___\/\\\_\//\\\__/\\\_____\/\\\_/\\______\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_]],
		-- [[       _\/\\\___\/\\\__\///\\\\\/______\//\\\\\________\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_]],
		-- [[        _\///____\///_____\/////_________\/////__________\///________\///////////__\///______________\///__]],

		-- [[ _____________________________________________________________        ]],
		-- [[  _____________________________________________________________       ]],
		-- [[   ____________________________________/\\\_____________________      ]],
		-- [[    ______________________/\\\____/\\\_\///_____/\\\\\__/\\\\\___     ]],
		-- [[     _____________________\//\\\__/\\\___/\\\__/\\\///\\\\\///\\\_    ]],
		-- [[      ______________________\//\\\/\\\___\/\\\_\/\\\_\//\\\__\/\\\_   ]],
		-- [[       _______________________\//\\\\\____\/\\\_\/\\\__\/\\\__\/\\\_  ]],
		-- [[        ________________________\//\\\_____\/\\\_\/\\\__\/\\\__\/\\\_ ]],
		-- [[         _________________________\///______\///__\///___\///___\///__]],

		startify.section.header.opts = { position = "left" }

		startify.section.mru_cwd.val = { { type = "padding", val = 0 } }

		startify.mru_opts.ignore = function(path, ext)
			return (string.find(path, "COMMIT_EDITMSG"))
		end

		startify.section.top_buttons.val = {
			{ type = "padding", val = 2 },
			startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			startify.button("f", "󰱼  Find File", "<cmd>Telescope find_files<CR>"),
			-- startify.button("r", "󰁯  Restore Session For Current Directory", "<cmd>Autosession restore<CR>"),
			startify.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
		}

		startify.section.bottom_buttons.val = {}

		startify.section.footer.val = {
			{ type = "padding", val = 1 },
			{ type = "text", val = "github.com/lemodoescoding", opts = { position = "left" } },
			{ type = "text", val = "notVIM v" .. tostring(vim.version()), opts = { position = "left" } },
			{
				type = "text",
				val = function()
					return require("fortune").get_fortune()
				end,
				opts = { position = "left" },
			},
		}

		alpha.setup(startify.config)

		vim.api.nvim_create_autocmd("VimResized", {
			callback = function()
				if vim.bo.filetype == "alpha" then
					vim.cmd("AlphaRedraw") -- Some versions of Alpha use this
					-- Or simply:
					-- vim.cmd("Alpha")
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "alpha" then
					vim.cmd("AlphaRedraw")
				end
			end,
		})

		vim.api.nvim_set_hl(0, "AlphaLogoLetters", { fg = "#F0C674", bold = true }) -- Gold/Yellow

		local alpha_hl_grp = vim.api.nvim_create_augroup("AlphaHighlights", { clear = true })

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			group = alpha_hl_grp,
			callback = function()
				-- Highlight slashes and backslashes in one color
				vim.fn.clearmatches()
				vim.fn.matchadd("AlphaLogoLetters", [[\/\\\+]])
			end,
		})

		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = "*",
			group = alpha_hl_grp,
			callback = function()
				if vim.bo.filetype == "alpha" then
					vim.fn.clearmatches()
				end
			end,
		})

		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
