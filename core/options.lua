local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

opt.iskeyword:append("-") -- consider string-string as whole word

vim.o.updatetime = 250

vim.opt.spell = true
vim.opt.spelllang = { "en", "ru" }
