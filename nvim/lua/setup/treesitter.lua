require("nvim-treesitter.configs").setup({
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"typescript",
			"markdown",
		},
	},
	incremental_selection = {
		enable = true,
	},
})
-- Setup treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({
	ensure_installed = {
		"python",
		"css",
		"scss",
		"typescript",
		"lua",
		"html",
		"javascript",
		"json",
		"rust",
		"yaml",
		"vim",
	},
	highlight = { enable = true },
})
