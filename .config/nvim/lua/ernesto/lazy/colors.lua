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

    {
      "gbprod/nord.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        require("nord").setup({
          -- transparent = true,
          terminal_colors = true,
          styles = {
            comments = {italic = false},
            -- functions = {bold = true},
          },
        })
        -- vim.cmd.colorscheme("nord")

        ColorMyPencils("nord")
        vim.cmd 'highlight Normal guibg=#2D303C'
      end,
    },

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
    --         bold_functions = true, -- enable bold text
    --       },
    --       colors = {
    --         -- background = "#df3f3f", -- set background color
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
    --     -- vim.api.nvim_set_hl(0, 'LineNr', { fg = '#d4be98' })
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
  

}
