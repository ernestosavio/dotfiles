return {
  "jpalardy/vim-slime",

  config = function()
    vim.g.slime_target = "tmux"
    -- Manda el código al panel de la derecha automáticamente
    vim.g.slime_default_config = { socket_name = "default", target_pane = ":3" }
    -- No te pregunta a qué panel mandar cada vez que ejecutás
    vim.g.slime_dont_ask_default = 1
    -- Clave para IA: formatea el texto especial para IPython
    vim.g.slime_python_ipython = 1 


    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.py",
        callback = function()
            local filepath = vim.fn.expand("%")
            local ipynb = vim.fn.expand("%:r") .. ".ipynb"
            
            -- Solo sincroniza si existe el archivo .ipynb vinculado en la carpeta
            if vim.fn.filereadable(ipynb) == 1 then
                -- Ejecuta jupytext silenciosamente
                vim.fn.system("jupytext --sync " .. filepath)
            end
        end,
        desc = "Sincronizar archivo Python con su Notebook Jupyter al guardar",
    })

  end,
}
