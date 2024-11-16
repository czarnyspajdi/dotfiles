-- Kolorystyka
vim.cmd.colorscheme("minimal")

-- Wygląd
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = false

-- Tabulatory i wcięcia
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Przewijanie i kursor
vim.opt.scrolloff = 8
vim.o.sidescrolloff = 8

-- Wyszukiwanie
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Ogólne ustawienia
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = true
vim.opt.updatetime = 50
