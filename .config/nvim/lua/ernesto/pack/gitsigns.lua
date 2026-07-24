vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
})

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function opts(desc)
      return { buffer = bufnr, desc = desc }
    end

    -- Saltar al próximo/anterior hunk (bloque de líneas cambiadas).
    -- vim.schedule evita interferir con el diff que gitsigns recalcula
    -- justo antes de moverse.
    vim.keymap.set("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.nav_hunk("next") end)
      return "<Ignore>"
    end, vim.tbl_extend("force", opts("Próximo cambio de git"), { expr = true }))

    vim.keymap.set("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.nav_hunk("prev") end)
      return "<Ignore>"
    end, vim.tbl_extend("force", opts("Cambio de git anterior"), { expr = true }))

    -- Ver el diff del hunk bajo el cursor, sin salir del archivo.
    vim.keymap.set("n", "<leader>gp", gs.preview_hunk, opts("Previsualizar cambio de git"))

    -- Deshacer los cambios del hunk actual (volver a como estaba en git).
    vim.keymap.set("n", "<leader>gr", gs.reset_hunk, opts("Descartar cambio de git"))

    -- Confirmar (stage) solo el hunk actual, no todo el archivo.
    vim.keymap.set("n", "<leader>gs", gs.stage_hunk, opts("Agregar cambio al stage"))

    -- Quién y cuándo tocó por última vez la línea del cursor.
    vim.keymap.set("n", "<leader>gb", function() gs.blame_line({ full = true }) end, opts("Ver blame de la línea"))
  end,
})
