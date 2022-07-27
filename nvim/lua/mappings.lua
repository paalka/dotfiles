local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local km = vim.keymap

km.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end)
km.set("n", "<leader>fw", function()
  require("telescope.builtin").live_grep()
end)
km.set("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser()
end)
km.set("n", "<leader>fp", function()
  require("telescope").extensions.repo.list{}
end)
km.set("n", "<leader>cc", function()
  require("telescope.builtin").command()
end)
km.set("n", "<leader>ss", function()
  require('session-lens').search_session()
end)

vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})

map("i", "jk", "<esc>")
