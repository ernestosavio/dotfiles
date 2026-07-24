-- Requisito nuevo: necesita el binario `tree-sitter` (el CLI) instalado
-- en tu sistema, porque ahora compila los parsers localmente.
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("nvim-treesitter").setup({})

require("nvim-treesitter").install({
  "javascript", "typescript", "python", "c", "lua",
  "vim", "vimdoc", "query", "haskell", "markdown", "typst",
})

-- "PackChanged" cada vez que instala, actualiza o borra un plugin.
-- Lo escuchamos para, cuando nvim-treesitter se actualice, refrescar
-- los parsers ya instalados y que sigan siendo compatibles.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      require("nvim-treesitter").update()
    end
  end,
  desc = "Actualizar parsers de treesitter cuando el plugin se actualiza",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
  desc = "Activar treesitter highlighting si hay parser disponible",
})

-- Indentado experimental
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "lua", "python" },
--   callback = function()
--     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--   end,
-- })
