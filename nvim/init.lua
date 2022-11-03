vim.o.termguicolors = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = '/home/ds/tmp/vim_undo_folder'

vim.o.clipboard = unnamedplus

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.cursorline = true
vim.o.relativenumber = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.g.mapleader = ','

------------------------------------------------
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>')

------------------------------------------------
vim.api.nvim_command([[:command Q q]])
vim.api.nvim_command [[colorscheme OceanicNext]]

------------------------------------------------
-- Highlight the region on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual' })
        -- This is a workaround for clipboard not working in WSL
        -- see https://github.com/neovim/neovim/issues/19204#issuecomment-1173722375
        -- if vim.fn.has('wsl') == 1 then
        --     vim.fn.system('clip.exe', vim.fn.getreg('"'))
        -- end
    end,
})

require('plugins')

