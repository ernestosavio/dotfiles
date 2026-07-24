-- harpoon depende de plenary.nvim en runtime (require("plenary.path"), etc).
-- Con lazy.nvim eso se declaraba con el campo `dependencies`. Con vim.pack
-- no existe ese campo: le pasamos los dos repos en la misma llamada a
-- vim.pack.add(), en orden (plenary primero), y listo.
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/ThePrimeagen/harpoon",
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-q>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-h>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(3) end)

