vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
  -- IMPORTANTE: default_file_explorer = true (el default) apaga netrw
  -- por completo, incluido el comando :Ex que usa tu <leader>pv. Lo
  -- ponemos en false para que los dos convivan sin pisarse.
  default_file_explorer = false,
  view_options = {
    show_hidden = true,
  },
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	 },
	columns = {
		"icon",
	},
	float = {
		max_width = 0.3,
		max_height = 0.6,
		border = "rounded",
    preview_split = "right",
	},
})

vim.keymap.set("n", "<leader>o", function()
  require("oil").open()
  vim.schedule(function()
    require("oil.actions").preview.callback()
  end)
end, { desc = "Explorador de archivos (oil)" })

-- Tip: una vez adentro de oil, apretá "g?" para ver TODOS sus mapeos
-- (incluido el que activa/desactiva el preview). Son mapeos internos
-- del buffer de oil, así que which-key no los va a mostrar solo.
