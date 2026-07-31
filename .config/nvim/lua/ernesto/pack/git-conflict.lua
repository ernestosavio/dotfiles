-- git-conflict resalta los marcadores de conflicto (<<<<<<<, =======,
-- >>>>>>>) apenas Neovim detecta que un archivo abierto los tiene, y
-- te da atajos para resolverlos SIN salir del archivo ni editar los
-- marcadores a mano.
vim.pack.add({
  "https://github.com/akinsho/git-conflict.nvim",
})

require("git-conflict").setup({
  default_mappings = true,
  default_commands = true,
})

-- Con default_mappings = true, estos atajos se activan SOLO dentro de
-- un buffer que tiene conflictos activos (no pisan nada el resto del
-- tiempo):
--   co  : quedarme con MI versión (ours)
--   ct  : quedarme con la de la OTRA rama (theirs)
--   cb  : quedarme con las DOS (both)
--   c0  : quedarme con la versión original antes de que ninguno tocara
--   ]x / [x : saltar al próximo/anterior conflicto en el archivo

-- Mandar TODOS los conflictos del proyecto (de todos los archivos) a
-- la quickfix list, para recorrerlos con <leader>k / <leader>j como ya
-- veníamos usando.
vim.keymap.set("n", "<leader>xc", "<cmd>GitConflictListQf<CR>", { desc = "Listar conflictos de git en quickfix" })
