local customs = {
	bg = "#011628",
	bg_dark = "#011423",
	bg_highlight = "#143652",
	bg_search = "#0a64ac",
	bg_visual = "#275378",
	fg = "#cbe0f0",
	fg_dark = "#b4d0e9",
	fg_gutter = "#627e97",
	border = "#547998",
}

return {
	-- {
	-- 	"bluz71/vim-nightfly-guicolors",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	priority = 1001,
	-- 	config = function()
	-- 		local catppuccin = require("catppuccin")
	-- 		catppuccin.setup({
	-- 			flavour = "mocha",
	-- 		})
	--
	-- 		vim.cmd([[colorscheme catppuccin]])
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			local tokyonight = require("tokyonight")
			tokyonight.setup({
				style = "moon",
				terminal_colors = true,
				on_colors = function(colors)
					colors.bg = customs.bg
					colors.bg_dark = customs.bg_dark
					colors.bg_float = customs.bg_dark
					colors.bg_highlight = customs.bg_highlight
					colors.bg_popup = customs.bg_dark
					colors.bg_search = customs.bg_search
					colors.bg_sidebar = customs.bg_dark
					colors.bg_statusline = customs.bg_dark
					colors.border = customs.border
					colors.fg = customs.fg
					colors.fg_dark = customs.fg_dark
					colors.fg_float = customs.fg
					colors.fg_gutter = customs.fg_gutter
					colors.fg_sidebar = customs.fg_dark
				end,
				styles = {
					comments = { italic = true },
					functions = { italic = true },
					variables = { italic = true },
				},
			})

			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{},
}
