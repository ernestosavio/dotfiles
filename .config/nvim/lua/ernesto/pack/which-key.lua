-- which-key lee automáticamente el campo `desc` que le pusimos a CADA
-- vim.keymap.set durante toda esta migración (telescope, harpoon, lsp...).
-- No hay que declarar nada de nuevo acá: apenas lo instalás, ya tiene
-- para mostrar. Por eso vale la pena el hábito de poner `desc` siempre.
vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup({})
