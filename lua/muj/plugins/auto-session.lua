vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		log_level = "info",

		-- added auto_save to auto save session on CWD
		auto_save = true,
		auto_restore = false,
		session_suppress_dirs = { "~/", "~/Dev", "~/Downloads", "~/Documents/", "~/Desktop/" },
	},
}
