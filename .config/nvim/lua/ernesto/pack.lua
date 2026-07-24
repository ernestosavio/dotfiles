-- vim.pack: gestor de plugins nativo de Neovim (>= 0.12)
--
-- No hay bootstrap: no clonamos ni instalamos ningún gestor externo.
-- vim.pack.add({ "url" }) clona el plugin la PRIMERA vez que se llama,
-- y en arranques siguientes solo lo agrega al runtimepath.
--
-- Cada plugin vive en su propio archivo dentro de lua/ernesto/pack/,
-- y ese archivo hace dos cosas seguidas: declara el plugin con
-- vim.pack.add(), y lo configura ahí mismo (setup(), keymaps, etc).
--
-- Acá simplemente los vamos a ir "prendiendo" a medida que migramos.

require("ernesto.pack.undotree")
require("ernesto.pack.harpoon")
require("ernesto.pack.treesitter")
require("ernesto.pack.telescope")
require("ernesto.pack.lsp")
require("ernesto.pack.typst-preview")

-- Colors
require("ernesto.pack.colors")

-- Test
require("ernesto.pack.which-key")
require("ernesto.pack.mini-files")
require("ernesto.pack.oil")

require("ernesto.pack.gitsigns")

require("ernesto.pack.quicker")
