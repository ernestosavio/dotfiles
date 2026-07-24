vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
})

-- telescope-fzf-native trae código en C que hay que compilar. Con lazy
-- esto era build = "make". Con vim.pack, mismo patrón que usamos en
-- treesitter: escuchamos PackChanged y corremos `make` nosotros mismos
-- en la carpeta donde vim.pack dejó el plugin (ev.data.path).
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "telescope-fzf-native.nvim"
        and (ev.data.kind == "install" or ev.data.kind == "update") then
      -- :wait() lo vuelve SINCRÓNICO: bloquea acá hasta que el make termine.
      -- Lo necesitamos así porque, un poco más abajo en este mismo archivo,
      -- llamamos a telescope.load_extension("fzf"), y esa llamada necesita
      -- que build/libfzf.so ya exista en el disco. Sin :wait(), el make
      -- sigue corriendo en background y load_extension llega demasiado
      -- temprano (esto fue justo lo que te rompió recién).
      local res = vim.system({ "make" }, { cwd = ev.data.path }):wait()
      if res.code ~= 0 then
        vim.notify("fzf-native: falló el make\n" .. (res.stderr or ""), vim.log.levels.ERROR)
      end
    end
  end,
  desc = "Compilar telescope-fzf-native con make (sincrónico)",
})

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    -- Muestra la ruta del archivo cuando hay nombres repetidos entre
    -- carpetas distintas, y la oculta cuando no hace falta.
    path_display = { "smart" },
  },
})

-- pcall: si por lo que sea la extensión no llegó a compilarse, que avise
-- y siga cargando el resto de la config en vez de tirar todo abajo.
if not pcall(telescope.load_extension, "fzf") then
  vim.notify("No se pudo cargar telescope-fzf-native (¿faltó compilar?)", vim.log.levels.WARN)
end

-- fzf-native ya acelera el sorter de cualquier picker, incluido este,
-- sin depender de ninguna librería nativa aparte de la que compilamos
-- con make. Es la mejora real de velocidad que buscábamos.
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Buscar archivos" })

vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Buscar archivos versionados en git" })

-- live_grep: vas escribiendo y los resultados se filtran en vivo,
-- sin tener que confirmar el texto antes como pasaba con grep_string.
vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Buscar texto en vivo en todo el proyecto" })
 
-- grep_string SIN argumentos busca automáticamente la palabra bajo el
-- cursor (antes la pisábamos con vim.fn.input, perdiendo ese default).
-- Útil para "¿dónde más se usa esta variable/función?" parado arriba de ella.
vim.keymap.set("n", "<leader>pw", builtin.grep_string, { desc = "Buscar la palabra bajo el cursor" })

vim.keymap.set("n", "<leader>bf", builtin.buffers, { desc = "Buscar entre buffers abiertos" })

vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Buscar en la ayuda de Neovim" })
