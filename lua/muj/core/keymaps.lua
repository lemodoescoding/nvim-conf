vim.g.mapleader = " "
local keymap = vim.keymap

-- basic and important keymaps

keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>q", ":wqa<CR>")
keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>qf", ":qa!<CR>")
keymap.set("n", "<leader>qw", ":wqa<CR>")

-- window splitting
keymap.set("n", "<leader>sv", "<C-w>v")     -- vertical
keymap.set("n", "<leader>sh", "<C-w>s")     -- horizontal
keymap.set("n", "<leader>se", "<C-w>=")     -- split equally
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split

-- tab
keymap.set("n", "<leader>to", ":tabnew<CR>")   -- new
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close
keymap.set("n", "<leader>tn", ":tabn<CR>")     -- next
keymap.set("n", "<leader>tp", ":tabp<CR>")     -- prev

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
