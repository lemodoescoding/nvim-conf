return {
	"xiyaowong/transparent.nvim",
	config = function()
		require("transparent").setup({
			extra_groups = {
				"NeoTreeNormal",
				"NeoTreeNormalNC",
				"NormalFloat",
			},
		})

		vim.api.nvim_set_keymap("n", "<leader>tt", ":TransparentToggle<CR>", { noremap = true, silent = true })
	end,
}
