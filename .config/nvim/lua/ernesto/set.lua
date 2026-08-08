vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Hace que no se me comenten los #ifdef sin importar si esta o no definido
vim.api.nvim_set_hl(0, '@lsp.type.comment.cpp', {})

vim.opt.winborder = "rounded"

vim.g.mapleader = " "

-- para marimo noteeboks
--vim.o.exrc = true

-- set.lua (agregar al final)

-- Providers que no usamos. Node/Perl/Python3 son solo para "remote
-- plugins" (plugins viejos escritos en esos lenguajes) — ninguno de
-- tus plugins actuales depende de esto. Apagarlos saca el warning del
-- checkhealth y ahorra un ratito en el arranque.
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
-- Si en algún momento instalás algo que sí necesite Python remoto (raro hoy en día),
-- sacás esa línea y agregás pynvim con nix/pip.
