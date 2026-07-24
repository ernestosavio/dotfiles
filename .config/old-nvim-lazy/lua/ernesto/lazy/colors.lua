function ColorMyPencils(color)
        color = color or "rose-pine"
        vim.cmd.colorscheme(color)

        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    -- {
    --     "folke/tokyonight.nvim",
	-- config = function()
	    -- require("tokyonight").setup({
	        -- style = "storm",
		-- transparent = true,
		-- terminal_colors = true,
		-- styles = {
		    -- comments = { italic = false },
		    -- keywords = { italic = false },
		    -- slidebars = "dark",
		    -- floats = "dark",
		-- },
	    -- })
	-- end
    -- },

    -- {
    --   'sainnhe/everforest',
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     -- Optionally configure and load the colorscheme
    --     -- directly inside the plugin declaration.
    --     -- vim.o.background = 'dark'
    --     vim.o.termguicolors = true
    --     vim.g.everforest_enable_italic = true
    --     vim.g.everforest_disable_italic_comment = true
    --     -- vim.g.everforest_ui_contrast = 'high' -- 'low'
    --     -- vim.g.everforest_transparent_background = 0
    --     -- vim.g.everforest_background = 'medium' -- 'soft', 'medium', 'hard'
    --     -- vim.g.everforest_better_performance = true
    --     -- vim.cmd.colorscheme('everforest')
    --     ColorMyPencils("everforest")
    --   end
    -- },

    -- {
    --   "gbprod/nord.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   config = function()
    --     require("nord").setup({
    --       -- transparent = true,
    --       terminal_colors = true,
    --       styles = {
    --         comments = {italic = false},
    --         -- functions = {bold = true},
    --         keywords = {bold = true},
    --       },
    --     })
    --     -- vim.cmd.colorscheme("nord")

    --     ColorMyPencils("nord")
    --     vim.cmd 'highlight Normal guibg=#2D303C'
    --   end,
    -- },

    -- {
    --   "ficcdaf/ashen.nvim",
    --   -- optional but recommended,
    --   -- pin to the latest stable release:
    --   tag = "*",
    --   lazy = false,
    --   priority = 1000,
    --   -- configuration is optional!
    --   config = function()
    --     require("ashen").setup({
    --       style_presets = {
    --         -- bold_functions = true, -- enable bold text
    --         bold_keywords = true, -- enable bold keywords
    --       },
    --       colors = {
    --         background = "#1a1a1a", -- set background color
    --       },
    --       -- hl = {
    --       --   merge_override = {
    --       --     LineNr      = { fg = "#d4be98" },         -- números normales
    --       --     CursorLineNr = { fg = "#ffcc00", bold = true },  -- número en la línea actual
    --       --     LineNrAbove  = { fg = "#a0a0a0" },        -- relativo arriba
    --       --     LineNrBelow  = { fg = "#a0a0a0" },        -- relativo abajo
    --       --   },
    --       -- },
    --     })

    --     ColorMyPencils("ashen")
    --     vim.api.nvim_set_hl(0, 'LineNr', { fg = '#d4be98' })
    --   end,
    -- },

    -- {
    --   'everviolet/nvim', name = 'evergarden',
    --   priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    --   config = function()
    --     require('evergarden').setup {
    --     theme = {
    --       variant = 'spring', -- 'winter'|'fall'|'spring'|'summer'
    --       accent = 'green',
    --     },
    --     editor = {
    --       transparent_background = false,
    --       sign = { color = 'none' },
    --       float = {
    --         color = 'mantle',
    --         invert_border = false,
    --       },
    --       completion = {
    --         color = 'surface0',
    --       },
    --     },
    --     style = {
    --       comments = { italic = false },
    --     },
    --   }

    --   ColorMyPencils("evergarden")

    --   end,
    -- }

    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --       require('nordic').setup({
    --         -- transparent = true,
    --         italic_comments = false,
    --         -- swap_backgrounds = false,
    --       })
    --       -- vim.cmd.colorscheme('nordic')
    --       require('nordic').load()
    --     end
    -- }

    --{
    --    "rose-pine/neovim",
    --     name = "rose-pine",
    --     config = function()
    --  	    --vim.cmd("colorscheme rose-pine")
	    --require('rose-pine').setup({
	        --disable_background = false
	    --})
	    --ColorMyPencils("everforest")
    --     end
    --},
  
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark" 
      vim.cmd.colorscheme("zenbones")

      local highlights = {
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
        LineNr       = { fg = "#C4C4C4" },                 -- Gris claro mucho más iluminado
        CursorLine   = { bg = "#333333" },                 
        CursorLineNr = { fg = "#CC5A7B", bold = true },    -- Línea actual en rosa mate y negrita
        Visual       = { bg = "#4A2E37" },                 
      }

      vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
        callback = function()
          -- Cambia 'IncSearch' por 'Visual' o 'Search' para que resalte en Zenbones
          vim.highlight.on_yank({ higroup = 'Visual' })
        end,
      })

      for group, colors in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, colors)
      end
    end,
  }

}
