local coq_settings = { auto_start = "shut-up" }
vim.api.nvim_set_var("coq_settings", coq_settings)
local coq = require("coq")

require("coq_3p") {
  { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
}
