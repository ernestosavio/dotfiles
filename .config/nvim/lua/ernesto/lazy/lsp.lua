return {

    "neovim/nvim-lspconfig",

    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },



    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          cmp_lsp.default_capabilities())

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "vimls",
            "clangd"
          },
          handlers = {
            function (server_name)

            require("lspconfig")[server_name].setup {
              capabilities = capabilities
            }
            end,

            ["lua_ls"] = function ()
              local lspconfig = require("lspconfig")
              lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { "vim" }
                    }
                  }
                }
              }
            end,
          }
        })

        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
          },
          mapping = cmp.mapping.preset.insert({
--            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--            ['<C-f>'] = cmp.mapping.scroll_docs(4),
--            ['<C-Space>'] = cmp.mapping.complete(),
--            ['<C-e>'] = cmp.mapping.abort(),
--              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
              ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
              ['<C-y>'] = cmp.mapping.confirm({ select = true }),
              ["<C-Space>"] = cmp.mapping.complete(),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            --{ name = 'vsnip' }, -- For vsnip users.
            { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
          }, {
              { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
          update_in_insert = true,
              float = { focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
                },
        })

  end
}
        -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        -- Set configuration for specific filetype.
        --[[ cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
     })
     require("cmp").setup() ]]-- 
