-- ==============================================================================
-- Selector de Tema
-- Lee el último tema elegido con :Theme <nombre> (o por el script theme-switch).
-- Si no hay nada guardado, usa "gray-vanilla" por default.
-- ==============================================================================
local state_file = vim.fn.stdpath("config") .. "/theme.txt"

local function read_active_theme()
  local f = io.open(state_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    if name and name ~= "" then return name end
  end
  return "gray-vanilla"
end

local active_theme = read_active_theme()

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
      "https://github.com/ficd0/ashen.nvim",
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

  -- ============================================================================
  -- gray-vanilla: mismos hex que ghostty/themes/gray-vanilla, waybar y tmux.
  -- Reusa zenbones.nvim como base (ya estaba instalado) y pisa los highlights.
  -- ============================================================================
  ["gray-vanilla"] = function()
    vim.pack.add({
      "https://github.com/rktjmp/lush.nvim",
      "https://github.com/zenbones-theme/zenbones.nvim",
    })
    vim.cmd.colorscheme("zenbones")

    local c = {
      bg0 = "#1c1b1a", -- fondo
      bg1 = "#242322", -- paneles / statusline
      bg2 = "#322f2b", -- selección / cursorline
      bg3 = "#403c37", -- bordes / separadores

      fg0 = "#ece4cd", -- texto principal
      fg1 = "#ddd3ba", -- texto (foreground base, igual que ghostty)
      fg2 = "#8a8272", -- comentarios / muted
      fg3 = "#635e52", -- line numbers

      vanilla     = "#e6bd5f", -- acento principal: keywords, cursor, títulos
      vanilla_dim = "#cfa562", -- strings, tipos
      grey_accent = "#b3ac9d", -- funciones, operadores

      red    = "#cf6b5c",
      green  = "#a8b06a",
      blue   = "#7ea3b0",
    }

    local hl = {
      Normal        = { bg = c.bg0, fg = c.fg1 },
      NormalFloat   = { bg = c.bg1, fg = c.fg1 },
      FloatBorder   = { bg = c.bg1, fg = c.bg3 },
      WinSeparator  = { fg = c.bg3, bg = c.bg0 },
      SignColumn    = { bg = c.bg0 },

      Comment       = { fg = c.fg2, italic = true },
      String        = { fg = c.vanilla_dim },
      Keyword       = { fg = c.vanilla, bold = true },
      Statement     = { fg = c.vanilla },
      Function      = { fg = c.grey_accent, bold = true },
      Identifier    = { fg = c.fg1 },
      Type          = { fg = c.vanilla_dim, bold = true },
      Constant      = { fg = c.vanilla },
      Number        = { fg = c.vanilla },
      Operator      = { fg = c.grey_accent },
      Special       = { fg = c.vanilla_dim },

      LineNr        = { fg = c.fg3 },
      CursorLineNr  = { fg = c.vanilla, bold = true },
      CursorLine    = { bg = c.bg2 },
      Cursor        = { bg = "#e0699e", fg = c.bg0 },
      lCursor       = { bg = "#e0699e", fg = c.bg0 },
      Visual        = { bg = c.bg2 },
      Search        = { bg = c.vanilla, fg = c.bg0 },
      IncSearch     = { bg = c.vanilla_dim, fg = c.bg0 },

      Pmenu         = { bg = c.bg1, fg = c.fg1 },
      PmenuSel      = { bg = c.bg2, fg = c.vanilla, bold = true },
      PmenuBorder   = { bg = c.bg1, fg = c.bg3 },

      StatusLine    = { bg = c.bg1, fg = c.fg1 },
      StatusLineNC  = { bg = c.bg1, fg = c.fg2 },

      DiagnosticError = { fg = c.red },
      DiagnosticWarn  = { fg = c.vanilla },
      DiagnosticInfo  = { fg = c.blue },
      DiagnosticHint  = { fg = c.grey_accent },

      GitSignsAdd    = { fg = c.green },
      GitSignsChange = { fg = c.vanilla },
      GitSignsDelete = { fg = c.red },
    }

    for group, colors in pairs(hl) do
      vim.api.nvim_set_hl(0, group, colors)
    end
  end,

  -- ============================================================================
  -- gray-vanilla-soft: misma base que gray-vanilla, menos contraste e intensidad.
  -- ============================================================================
  ["gray-vanilla-soft"] = function()
    vim.pack.add({
      "https://github.com/rktjmp/lush.nvim",
      "https://github.com/zenbones-theme/zenbones.nvim",
    })
    vim.cmd.colorscheme("zenbones")

    local c = {
      bg0 = "#1c1b1a",
      bg1 = "#242322",
      bg2 = "#322f2b",
      bg3 = "#403c37",

      fg0 = "#ded7c5",
      fg1 = "#cdc5b3",
      fg2 = "#7d786e",
      fg3 = "#5c584e",

      vanilla     = "#cbbb95",
      vanilla_dim = "#b8a888",
      grey_accent = "#a29c92",

      red    = "#b57972",
      green  = "#9da585",
      blue   = "#93a3aa",
    }

    local hl = {
      Normal        = { bg = c.bg0, fg = c.fg1 },
      NormalFloat   = { bg = c.bg1, fg = c.fg1 },
      FloatBorder   = { bg = c.bg1, fg = c.bg3 },
      WinSeparator  = { fg = c.bg3, bg = c.bg0 },
      SignColumn    = { bg = c.bg0 },

      Comment       = { fg = c.fg2, italic = true },
      String        = { fg = c.vanilla_dim },
      Keyword       = { fg = c.vanilla, bold = true },
      Statement     = { fg = c.vanilla },
      Function      = { fg = c.grey_accent, bold = true },
      Identifier    = { fg = c.fg1 },
      Type          = { fg = c.vanilla_dim, bold = true },
      Constant      = { fg = c.vanilla },
      Number        = { fg = c.vanilla },
      Operator      = { fg = c.grey_accent },
      Special       = { fg = c.vanilla_dim },

      LineNr        = { fg = c.fg3 },
      CursorLineNr  = { fg = c.vanilla, bold = true },
      CursorLine    = { bg = c.bg2 },
      Cursor        = { bg = "#e0699e", fg = c.bg0 },
      lCursor       = { bg = "#e0699e", fg = c.bg0 },
      Visual        = { bg = c.bg2 },
      Search        = { bg = c.vanilla, fg = c.bg0 },
      IncSearch     = { bg = c.vanilla_dim, fg = c.bg0 },

      Pmenu         = { bg = c.bg1, fg = c.fg1 },
      PmenuSel      = { bg = c.bg2, fg = c.vanilla, bold = true },
      PmenuBorder   = { bg = c.bg1, fg = c.bg3 },

      StatusLine    = { bg = c.bg1, fg = c.fg1 },
      StatusLineNC  = { bg = c.bg1, fg = c.fg2 },

      DiagnosticError = { fg = c.red },
      DiagnosticWarn  = { fg = c.vanilla },
      DiagnosticInfo  = { fg = c.blue },
      DiagnosticHint  = { fg = c.grey_accent },

      GitSignsAdd    = { fg = c.green },
      GitSignsChange = { fg = c.vanilla },
      GitSignsDelete = { fg = c.red },
    }

    for group, colors in pairs(hl) do
      vim.api.nvim_set_hl(0, group, colors)
    end
  end,

  -- ============================================================================
  -- coral-gray: tu zenbones personalizado (gris + rosa coral), con cursor rosa
  -- sumado. Mismos hex que ghostty/waybar/tmux/swaylock del tema "coral-gray".
  -- ============================================================================
  ["coral-gray"] = function()
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
      Cursor       = { bg = "#e0699e", fg = "#2A2A2A" },
      lCursor      = { bg = "#e0699e", fg = "#2A2A2A" },
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

-- ==============================================================================
-- :Theme <nombre>  -> cambia el tema en la sesión actual y lo guarda para
-- la próxima vez que abras nvim. El script theme-switch escribe el mismo
-- archivo, así que ambos caminos quedan sincronizados.
-- ==============================================================================
vim.api.nvim_create_user_command("Theme", function(opts)
  local name = opts.args
  if not theme_configs[name] then
    vim.notify("Tema no definido: " .. name, vim.log.levels.ERROR)
    return
  end
  local ok, err = pcall(theme_configs[name])
  if not ok then
    vim.notify("Error al cargar '" .. name .. "': " .. tostring(err), vim.log.levels.ERROR)
    return
  end
  active_theme = name
  local f = io.open(state_file, "w")
  if f then
    f:write(name)
    f:close()
  end
  vim.notify("Tema: " .. name)
end, {
  nargs = 1,
  complete = function()
    return { "gray-vanilla", "gray-vanilla-soft", "coral-gray" }
  end,
})
