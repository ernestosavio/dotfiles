-- ==============================================================================
-- Selector de Tema (Cambiá este string para cambiar de tema)
-- ==============================================================================
local active_theme = "zenbones"

vim.o.background = "dark"
vim.o.termguicolors = true

-- ==============================================================================
-- Configuraciones de cada tema
-- ==============================================================================
local theme_configs = {

  tokyonight = function()
    vim.pack.add({
      "https://github.com/folke/tokyonight.nvim",
    })
    require("tokyonight").setup({
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "dark",
        floats = "dark",
      },
    })
    vim.cmd.colorscheme("tokyonight-storm")
  end,

  everforest = function()
    vim.pack.add({
      "https://github.com/sainnhe/everforest",
    })
    vim.g.everforest_enable_italic = true
    vim.g.everforest_disable_italic_comment = true
    vim.cmd.colorscheme("everforest")
    -- Si tenías tu función ColorMyPencils, podés aplicar highlights extra acá
  end,

  nord = function()
    vim.pack.add({
      "https://github.com/shaunsingh/nord.nvim",
    })
    require("nord").setup({
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { bold = true },
      },
    })
    vim.cmd.colorscheme("nord")
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#2D303C' })
  end,

  ashen = function()
    vim.pack.add({
      "https://github.com/sainnhe/everforest",
    })
    require("ashen").setup({
      style_presets = { bold_keywords = true },
      colors = { background = "#1a1a1a" },
    })
    vim.cmd.colorscheme("ashen")
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#d4be98' })
  end,

  evergarden = function()
    vim.pack.add({
      "https://github.com/everviolet/nvim",
    })
    require('evergarden').setup {
      theme = { variant = 'spring', accent = 'green' },
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = { color = 'mantle', invert_border = false },
        completion = { color = 'surface0' },
      },
      style = { comments = { italic = false } },
    }
    vim.cmd.colorscheme("evergarden")
  end,

  nordic = function()
    vim.pack.add({
      "https://github.com/AlexvZyl/nordic.nvim",
    })
    require('nordic').setup({
      italic_comments = false,
    })
    require('nordic').load()
  end,

  rose_pine = function()
    vim.pack.add({
      "https://github.com/rose-pine/neovim",
    })
    require('rose-pine').setup({
      disable_background = false,
    })
    vim.cmd.colorscheme("rose-pine")
  end,

  koda = function()
    vim.pack.add({
      "https://github.com/oskarnurm/koda.nvim",
    })
    vim.cmd.colorscheme("koda")
  end,

  zenbones = function()
    vim.pack.add({
      "https://github.com/rktjmp/lush.nvim",
      "https://github.com/zenbones-theme/zenbones.nvim",
    })
    vim.cmd.colorscheme("zenbones")
    
    local custom_highlights = {
      Normal       = { bg = "#2A2A2A", fg = "#D0D0D0" }, 
      Comment      = { fg = "#7A7A7A", italic = true },  
      String       = { fg = "#A8A8A8" },                 
      Keyword      = { fg = "#CC5A7B", bold = true },    
      Function     = { fg = "#C4788D" },                 
      Identifier   = { fg = "#D0D0D0" },                 
      Type         = { fg = "#CC5A7B", bold = true },    
      Constant     = { fg = "#E3B1C0" },                 
      Number       = { fg = "#E3B1C0" },                 
      Statement    = { fg = "#CC5A7B" },                 
      Operator     = { fg = "#999999" },                 
      LineNr       = { fg = "#C4C4C4" },                 
      CursorLine   = { bg = "#333333" },                 
      CursorLineNr = { fg = "#CC5A7B", bold = true },    
      Visual       = { bg = "#4A2E37" },                 
    }
      
    for group, colors in pairs(custom_highlights) do
      vim.api.nvim_set_hl(0, group, colors)
    end

  end,

  zenbones2 = function()
    vim.pack.add({
      "https://github.com/rktjmp/lush.nvim",
      "https://github.com/zenbones-theme/zenbones.nvim",
    })
    vim.cmd.colorscheme("zenbones")
  end

}

    
-- ==============================================================================
-- Ejecución
-- ==============================================================================


vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end,
})


-- Busca la función del tema elegido en la tabla y la ejecuta de forma segura
if theme_configs[active_theme] then
  local ok, err = pcall(theme_configs[active_theme])
  if not ok then
    print("Error al cargar el tema '" .. active_theme)
    print("Detalle: " .. tostring(err))
  end
else
  print("El tema '" .. active_theme .. "' no está definido en la configuración.")
end
