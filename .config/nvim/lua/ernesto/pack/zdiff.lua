-- zdiff: revisor de diffs multi-archivo (inspirado en el de Zed).
-- Te muestra, en una sola vista colapsable, todos los archivos
-- cambiados y sus hunks — bueno para revisar ANTES de commitear, o
-- para comparar tu rama contra otra antes de mergear. No resuelve
-- conflictos con marcadores <<<<<<< (para eso, más adelante,
-- git-conflict.nvim).
vim.pack.add({
  "https://github.com/martindur/zdiff.nvim",
})

require("zdiff").setup({
  default_branch = "main", -- cambiá esto si tu rama principal es "master"
})

-- Ver cambios sin commitear (staged + sin stagear) contra HEAD.
vim.keymap.set("n", "<leader>zd", "<cmd>Zdiff<CR>", { desc = "Zdiff: cambios sin commitear" })

-- Ver todo lo que cambia tu rama actual respecto a main/master.
-- Justo lo que sirve ANTES de abrir un PR o hacer merge, para
-- revisar de una todo lo que vas a traer.
vim.keymap.set("n", "<leader>zD", "<cmd>Zdiff main<CR>", { desc = "Zdiff: rama actual vs main" })
