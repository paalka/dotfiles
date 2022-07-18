-- Telescope Global remapping
local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    history = {
      path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      limit = 100,
    },
    generic_sorter = require('telescope.sorters').get_fzy_sorter,
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    sorting_strategy = "descending",
    prompt_prefix = "   ",
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      sort_mru = true,
      ignore_current_buffer = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
  },
  extensions = {
          project = {
                  base_dirs = {
                          '~/dev/',
                  },
                  hidden_files = true, -- default: false
                  theme = "dropdown"
          }
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
require("telescope").load_extension("smart_history")
require("telescope").load_extension("session-lens")

