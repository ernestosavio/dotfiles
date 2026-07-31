-- ============================================================
-- LSP nativo (Neovim 0.11+) + autocompletado nativo (Neovim 0.12+)
-- ============================================================
-- SACAMOS del todo: nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path,
-- cmp-cmdline y LuaSnip. Neovim ya no los necesita para lo básico.
--
-- Quién hace qué ahora:
--  - mason.nvim          : instala los binarios de los servers LSP.
--  - mason-lspconfig.nvim: detecta lo que instalaste con mason y llama
--                          vim.lsp.enable() por vos (es el default,
--                          "automatic_enable"). Antes hacía esto con
--                          una tabla de `handlers`; ese mecanismo viejo
--                          ya no existe.
--  - nvim-lspconfig      : ya NO llamamos a su .setup() por server.
--                          Solo lo dejamos en el runtimepath para que
--                          aporte las definiciones por defecto (cmd,
--                          filetypes, root markers) de cada lenguaje.
--  - vim.lsp.config()    : acá nosotros pisamos esa definición cuando
--                          necesitamos algo particular (como los
--                          globals de "vim" para lua_ls).
vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/neovim/nvim-lspconfig",
})

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Ajustes puntuales por servidor. OJO: vim.lsp.config() tiene que
-- llamarse ANTES de que el server se prenda, por eso va antes del
-- setup() de mason-lspconfig más abajo.
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "vimls", "clangd", "pyright" },
  -- automatic_enable = true (default): no hace falta llamar
  -- vim.lsp.enable() a mano, mason-lspconfig lo hace por cada
  -- server que instalaste vía `ensure_installed` (o :Mason).
})

-- ---------------------------------------------------------------
-- Autocompletado nativo: reemplaza a nvim-cmp
-- ---------------------------------------------------------------
vim.o.autocomplete = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
-- Nota: <C-n>/<C-p> para moverse y <C-y>/<C-e> para confirmar/cancelar
-- YA son los mapeos por defecto de Neovim para el menú de completado.
-- Antes los definías vos mismo adentro de cmp.setup({ mapping = ... }).

-- vim.o.autocomplete es GLOBAL: se prende en cualquier buffer en modo
-- inserción, incluida la cajita de búsqueda de Telescope (que es un
-- buffer normal, de filetype "TelescopePrompt"). Ahí no lo queremos,
-- así que lo apagamos puntual para ese filetype con vim.bo (la versión
-- "buffer-local" de vim.o: pisa el valor global solo en ese buffer).
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.bo.autocomplete = false
  end,
  desc = "No mostrar autocompletado nativo dentro de Telescope",
})

-- ---------------------------------------------------------------
-- LspAttach: UN SOLO autocomando central para todos los servers
-- ---------------------------------------------------------------
-- Antes, con lspconfig, cada server que agregabas necesitaba su propio
-- `on_attach` (o repetir los mismos keymaps en el handler genérico).
-- LspAttach se dispara automáticamente cada vez que CUALQUIER server
-- se conecta a un buffer, así que definís los keymaps una sola vez acá.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, {
        autotrigger = true,
        -- convert: te deja decidir qué mostrar por cada columna del
        -- menú nativo, ítem por ítem. Sin esto, solo se ve la palabra.
        -- Acá le agregamos:
        --   kind -> "Function", "Field", "Variable"... (lo que el LSP
        --           mande como tipo de símbolo)
        --   menu -> el "detail" del LSP: en una función, su firma
        --           completa (los mismos paréntesis con los tipos de
        --           argumento que veías en tu nvim-cmp viejo)
        convert = function(item)
          local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or ""
          return {
            abbr = item.label,
            kind = kind,
            menu = item.detail or "",
          }
        end,
      })
    end

    -- vim.tbl_extend("force", t1, t2): junta dos tablas en una nueva.
    -- "force" dice qué hacer si una clave se repite en las dos: gana
    -- la de t2. Lo usamos para partir de las opciones base ({buffer=...})
    -- y sumarle una `desc` distinta en cada keymap sin repetir el buffer.
    local base = { buffer = args.buf }
    local function opts(desc)
      return vim.tbl_extend("force", base, { desc = desc })
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Documentación (hover)"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Ir a la definición"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Ir a la declaración"))
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts("Ir a la implementación"))
    vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, opts("Ver referencias"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Renombrar en todo el proyecto"))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Acciones de código"))
    vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, opts("Formatear buffer"))
    -- Signature help: mientras escribís los argumentos de una llamada,
    -- muestra qué parámetros espera la función, en un float chiquito.
    -- Va en modo INSERT porque es justo cuando estás tipeando adentro
    -- de los paréntesis que sirve.
    if client:supports_method("textDocument/signatureHelp") then
      vim.keymap.set("i", "<C-Tab>", vim.lsp.buf.signature_help, opts("Ver firma de la función"))
    end

    -- Symbols: document = todo lo definido en ESTE archivo (para saltar
    -- directo a una función sin scrollear). Workspace = lo mismo pero
    -- buscando en TODO el proyecto por nombre, sin importar el archivo.
    if client:supports_method("textDocument/documentSymbol") then
      vim.keymap.set(
        "n", "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        opts("Símbolos de este archivo")
      )
    end
    if client:supports_method("workspace/symbol") then
      vim.keymap.set(
        "n", "<leader>ws",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        opts("Buscar símbolo en todo el proyecto")
      )
    end

    -- Inlay hints: texto fantasma inline con tipos/nombres de parámetro
    -- (ej: function(x: number)). Nativo desde Neovim 0.10, apagado por
    -- default. Cada LSP decide si los soporta (lua_ls y clangd sí,
    -- vimls no).
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      -- Por si en algún momento te resultan molestos/ruidosos y
      -- querés apagarlos sin reiniciar nvim:
      vim.keymap.set("n", "<leader>th", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
      end, opts("Prender/apagar inlay hints"))
    end
  end,
})

-- ---------------------------------------------------------------
-- Saltar entre placeholders de un snippet LSP (reemplaza a LuaSnip
-- para el caso de uso que ya tenías: expandir snippets que manda
-- el propio language server). Neovim ya trae esto nativo desde 0.10.
-- ---------------------------------------------------------------
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active({ direction = 1 }) then
    return vim.snippet.jump(1)
  end
end, { desc = "Siguiente placeholder del snippet" })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active({ direction = -1 }) then
    return vim.snippet.jump(-1)
  end
end, { desc = "Placeholder anterior del snippet" })

-- Saltar al próximo/anterior diagnostic (error, warning, etc) SIN
-- necesidad de abrir ningún listado. Es global (no depende de qué
-- server esté conectado), por eso va afuera del LspAttach.
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Próximo diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic anterior" })

vim.diagnostic.config({
  update_in_insert = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.keymap.set(
  "n",
  "<leader>de",
  "<cmd>Telescope diagnostics bufnr=0 theme=dropdown prompt_title=diagnostics previewer=false<CR>",
  { desc = "Ver diagnostics del buffer actual" }
)
