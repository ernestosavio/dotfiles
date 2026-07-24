vim.pack.add({
  "https://github.com/chomosuke/typst-preview.nvim",
})

require('typst-preview').setup({})

vim.keymap.set("n", "<leader>fp", "<cmd>TypstPreview<cr>", { desc = "Typst Preview" })
