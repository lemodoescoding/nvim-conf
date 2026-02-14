vim.g.mapleader = " "
local keymap = vim.keymap

-- basic and important keymaps

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>qq", ":wqa<CR>")
keymap.set("n", "<leader>wb", ":w<CR>")
keymap.set("n", "<leader>qf", ":qa!<CR>")
keymap.set("n", "<leader>qw", ":wqa<CR>")

-- window splitting
keymap.set("n", "<leader>sv", "<C-w>v") -- vertical
keymap.set("n", "<leader>sh", "<C-w>s") -- horizontal
keymap.set("n", "<leader>se", "<C-w>=") -- split equally
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split

-- tab
keymap.set("n", "<leader>to", ":tabnew<CR>") -- new
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next
keymap.set("n", "<leader>tp", ":tabp<CR>") -- prev

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- open h-v terminal
keymap.set("n", "<leader>tb", ":split term://zsh<CR>")
keymap.set("n", "<leader>tv", ":vsplit term://zsh<CR>")

-- window cursor switcher
keymap.set("n", "<C-Left>", "<C-w>>")
keymap.set("n", "<C-Right>", "<C-w><")
keymap.set("n", "<C-Up>", "<C-w>+")
keymap.set("n", "<C-Down>", "<C-w>-")

vim.keymap.set("n", "<leader>ip", function()
	local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
	if venv ~= nil then
		-- in the form of /home/benlubas/.virtualenvs/VENV_NAME
		venv = string.match(venv, "/.+/(.+)")
		vim.cmd(("MoltenInit %s"):format(venv))
	else
		vim.cmd("MoltenInit python3")
	end
end, { desc = "Initialize Molten for python3", silent = true })
