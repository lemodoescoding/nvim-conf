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

opt.iskeyword:append({"/", "-"})

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

-- truncate LSP log on every startup so it never bloats
local log_path = vim.lsp.get_log_path()
local log = io.open(log_path, "w")
if log then
    log:close()
end

-- keep log level strict so it writes as little as possible
vim.lsp.set_log_level("ERROR")

-- clear log if it grows beyond 10MB during a session
vim.api.nvim_create_autocmd("FocusGained", {
    callback = function()
        local log_size = vim.fn.getfsize(vim.lsp.get_log_path())
        if log_size > 10 * 1024 * 1024 then
            local f = io.open(vim.lsp.get_log_path(), "w")
            if f then f:close() end
        end
    end,
})
