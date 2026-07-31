-- blink.cmp reemplaza TODO el autocompletado nativo que armamos antes
-- (vim.o.autocomplete, completeopt, la función convert, el salto de
-- snippets con vim.snippet). Es "batteries included": trae de fábrica
-- las fuentes de LSP, buffer, rutas de archivo y snippets — con
-- nvim-cmp necesitabas un plugin aparte por cada una.
vim.pack.add({
  -- Colección de snippets ya escritos (for, if, try/catch...) para
  -- cuando el LSP no te manda uno propio.
  --"https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("blink.cmp").setup({
  -- "default": <C-n>/<C-p> para moverte, <C-y> para confirmar,
  -- <Tab>/<S-Tab> para saltar entre placeholders de un snippet.
  keymap = {
    preset = "default",
    ['<C-e>'] = { 'select_and_accept', 'fallback' },
},

  appearance = {
    -- Necesita una Nerd Font instalada en tu terminal para los íconos
    -- por tipo de símbolo (función, campo, variable...). Si tu
    -- terminal no tiene una, poné "mono" acá y vas a ver texto en vez
    -- de íconos, sin romper nada.
    nerd_font_variant = "normal",
  },

  completion = {
    -- Documentación del ítem seleccionado, en un popup al costado.
    documentation = { auto_show = false, auto_show_delay_ms = 200 },
    menu = {
      draw = {
        -- ícono de tipo + nombre + firma/detail al lado de cada ítem.
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
      },
    },
  },

  -- Firma de la función mientras escribís los argumentos, automática
  signature = { enabled = true },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  -- "prefer_rust_with_warning": usa el matcher fuzzy en Rust (mucho
  -- más rápido y tolerante a typos) si hay un binario prebuilt para tu
  -- sistema operativo; si no lo encuentra, cae en la versión Lua pura
  -- sin romper nada, solo avisa.
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
