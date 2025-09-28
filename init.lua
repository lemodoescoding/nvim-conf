require("muj.core.options")
require("muj.core.keymaps")
require("muj.lazy")

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.o.mouse = "a" -- enable mouse in all mode
-- vim.o.mousemoveevent = true -- enable mouse move event (currenly only used for bufferline)

vim.cmd([[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi StatusLine guibg=NONE ctermbg=NONE
  hi StatusLineNC guibg=NONE ctermbg=NONE
]])

vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		if vim.bo.filetype == "neo-tree" and vim.fn.winnr("$") == 1 then
			vim.cmd("quit")
		end
	end,
})
