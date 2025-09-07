return {
  {
    "nvim-lua/plenary.nvim",
    name = "plenary"
  },

  "mbbill/undotree",

  -- "github/copilot.vim",

  "https://github.com/tpope/vim-commentary",

  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    opts = {},    -- lazy.nvim will implicitly calls `setup {}`

    config = function()
      -- Mapeos
      vim.keymap.set("n", "<leader>fp", "<cmd>TypstPreview<cr>", { desc = "Typst Preview" })


      -- vim.cmd([[
      --   setlocal wrapmargin=10
      --   setlocal formatoptions+=t
      --   setlocal textwidth=80
      --   setlocal linebreak
      --   setlocal spell spelllang=en_us,es
      -- ]])
      -- Opciones de buffer local para archivos Typst
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "typst",
        callback = function()
          vim.opt_local.wrapmargin = 10
          vim.opt_local.formatoptions:append("t")
 --         vim.opt_local.textwidth = 80
          vim.opt_local.linebreak = true
          vim.opt_local.spell = true
          vim.opt_local.spelllang = { "en_us", "es" }
        end,
      })
    end,
  } -- Creo que wrapmargin no se aplica por textwidth (lo sobreescribe)
}
