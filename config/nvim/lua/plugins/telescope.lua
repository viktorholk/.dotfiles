local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  }
}


function M.config()
  local telescope = require('telescope')
  telescope.setup {
    pickers = {
      find_files = {
        theme = 'ivy'
      },
      live_grep = {
        theme = 'ivy'
      },
      buffers = {
        theme = 'ivy'
      }
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }
  telescope.load_extension('fzf')
end

return M