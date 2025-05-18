-- colorscheme
vim.opt.termguicolors = true
vim.cmd[[colorscheme tokyonight-night]]

-- options
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.o.signcolumn = "yes"
vim.o.numberwidth = 4

-- Optional: always show line numbers
vim.o.number = true
vim.o.relativenumber = false

-- Disable deprecate messages
vim.deprecate = function() end
