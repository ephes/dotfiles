-- Options are automatically loaded before lazy.nvim startup
-- Add any additional options here

local opt = vim.opt

-- Fix "No such group: FileExplorer" error (netrw disabled by LazyVim)
vim.api.nvim_create_augroup("FileExplorer", { clear = true })

-- Python host (uv-managed venv with pynvim)
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/python/bin/python")

-- Tabs & Indentation (4 spaces, matching old .vimrc)
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Line numbers
opt.relativenumber = true
opt.number = true

-- System clipboard
opt.clipboard = "unnamedplus"

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Update time (faster completion)
opt.updatetime = 200
opt.timeoutlen = 300
