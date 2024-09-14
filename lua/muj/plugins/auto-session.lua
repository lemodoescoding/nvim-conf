vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
	"rmagatti/auto-session",
  	config = function()
		require("auto-session").setup({
			log_level = "info",

      -- added auto_save to auto save session on CWD
      auto_save = true,
			auto_restore = false,
			session_suppress_dirs = { "~/", "~/Dev", "~/Downloads", "~/Documents/", "~/Desktop/" },
		})

		local keyset = vim.keymap.set

		-- keyset("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
		-- keyset("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
		-- keyset("n", "<leader>wd", "<cmd>Autosession delete<CR>", { desc = "Select session to delete" })
		-- keyset("n", "<leader>we", "<cmd>Autosession search<CR>", { desc = "Select session to restore" })
	end,
}
