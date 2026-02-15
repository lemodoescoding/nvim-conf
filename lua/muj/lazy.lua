local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.loader.enable()

require("lazy").setup({
	{ import = "muj.plugins" },
	{ import = "muj.plugins.py" },
	{ import = "muj.plugins.editor" },
	{ import = "muj.plugins.explorer" },
	{ import = "muj.plugins.ui" },
	{ import = "muj.dap" },
	-- { import = "muj.coc"},
	{ import = "muj.lsp" },
}, {
	install = {
		colorscheme = { "nightfly" },
	},

	checker = {
		enabled = true,
		notify = false,
	},

	change_detection = {
		notify = false,
	},
})
