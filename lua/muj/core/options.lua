local opt = vim.opt

opt.cmdheight = 0

-- line numbers
opt.relativenumber = true
opt.number = true

-- tab and indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- line wrapping

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split window
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
