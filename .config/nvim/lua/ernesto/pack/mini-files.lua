vim.pack.add({
  "https://github.com/nvim-mini/mini.files",
})

require("mini.files").setup({
  options = {
    use_as_default_explorer = false,
  },
  windows = {
    -- Con preview=true ves el contenido del archivo bajo el cursor
    -- sin tener que abrirlo, útil para "orientarte" rápido.
    --preview = true,
    width_focus = 30,
  },
})

-- No pisamos <leader>pv (ese sigue siendo tu netrw de siempre, en
-- remap.lua). mini.files queda en una tecla aparte, para cuando lo
-- quieras usar puntualmente a ver el árbol del proyecto.
vim.keymap.set("n", "<leader>t", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Explorador de archivos (mini.files)" })

-- Navegación adentro de mini.files (ya viene por defecto, lo anoto para
-- que sepas qué esperar la primera vez que lo abras):
--   <CR> o l   : entrar a la carpeta / abrir el archivo
--   -   o h    : subir a la carpeta padre
--   g~         : ir al $HOME
--   .          : mostrar/ocultar archivos ocultos
--   q          : cerrar el explorador
