-- actions-preview.nvim: antes de aplicar una code action del LSP, te
-- muestra en Telescope el DIFF exacto de qué va a cambiar. Sin esto,
-- vim.lsp.buf.code_action() aplica la opción elegida directamente,
-- sin mostrar antes qué es lo que va a tocar.
--
-- nvim-lightbulb: dibuja un ícono en la columna de signos cada vez que
-- el cursor está parado sobre algo con code action disponible.
vim.pack.add({
  "https://github.com/aznhe21/actions-preview.nvim",
  "https://github.com/kosayoda/nvim-lightbulb",
})

require("actions-preview").setup({
  backend = { "telescope" },
  -- get_dropdown(): el mismo theme compacto que ya conocés de otros
  -- pickers de telescope, para que la preview no te tape media pantalla.
  telescope = require("telescope.themes").get_dropdown({}),
})

require("nvim-lightbulb").setup({
  -- El plugin escucha sus propios autocmd (CursorHold, etc), no hace
  -- falta que vos definas ninguno a mano.
  autocmd = { enabled = true },
  sign = {
    enabled = true,
    text = "💡",
  },
})
