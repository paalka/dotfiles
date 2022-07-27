vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[,]]

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7 -- Lines of context
vim.opt.expandtab = true
vim.opt.signcolumn     = "yes"
vim.opt.termguicolors = true

vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"
vim.opt.undofile = true

vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

vim.o.shiftround       = true       -- align indent to next multiple value of shiftwidth
vim.o.shiftwidth       = 2          -- Number of auto-indent spaces
vim.o.softtabstop      = 2          -- Number of spaces per Tab
vim.o.smarttab         = true       -- Enable smart-tabs
vim.o.expandtab        = true       -- Insert spaces when tab pressed

--Incremental live completion
vim.o.inccommand = 'nosplit'
vim.o.lazyredraw = true

--Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true
