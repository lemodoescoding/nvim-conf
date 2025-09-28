return {
	"xiyaowong/transparent.nvim",
	config = function()
		require("transparent").setup({
			extra_groups = {
				-- for Telescope
				"TelescopeNormal", -- telescope main background
				"TelescopeBorder", -- telescope border
				"TelescopePromptNormal",
				"TelescopePromptBorder",
				"TelescopeResultsNormal",
				"TelescopeResultsBorder",
				"TelescopePreviewNormal",
				"TelescopePreviewBorder",
				"TelescopeTitle",
				"TelescopePromptTitle",
				"TelescopeResultsTitle",
				"TelescopePreviewTitle",

				-- for Neo-tree
				"NormalFloat",
				"NeoTreeNormal",
				"NeoTreeNormalNC",
				"NeoTreeEndOfBuffer",
				"NeoTreeFloatBorder",
				"NeoTreeFloatTitle",
				"NeoTreeTabActive",
				"NeoTreeTabInactive",
				"NeoTreeTabSeparatorActive",
				"NeoTreeTabSeparatorInactive",
			},
		})

		vim.api.nvim_set_keymap("n", "<leader>tt", ":TransparentToggle<CR>", { noremap = true, silent = true })
	end,
}
