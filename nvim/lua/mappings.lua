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
km.set("n", "<leader>ss", function()
  require('session-lens').search_session()
end)
km.set("n", "<leader>cc", function()
  require("telescope.builtcin").commands()
end)
km.set("n", "<leader>pp", function()
  require("telescope").extensions.project.project{}
end)

map("i", "jk", "<esc>")
