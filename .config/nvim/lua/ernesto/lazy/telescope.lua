return {
  
  "nvim-telescope/telescope.nvim",

  dependencies = {
      "plenary"
  },

    config = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
	vim.keymap.set('n', '<C-P>', builtin.git_files, {})
	vim.keymap.set('n', '<leader>ps', function()
		builtin.grep_string({ search = vim.fn.input("Grep > ") });
	end)
  vim.keymap.set('n', '<leader>bf', function()
    builtin.buffers({'[b]uffer fuzzy find'});
    end)
  vim.keymap.set('n', '<leader>h', function()
    builtin.help_tags({'[h]elp [f]ind'});
    end)
  end
}
