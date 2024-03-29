local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      { "i", "c" }
    ),
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
      keyword_length = 0,
  },
  sources = {
    { name = "nvim_lsp", max_item_count = 5 },
    { name = "vsnip", max_item_count = 3 },
    {
      name = "buffer",
      max_item_count = 7,
      option = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = "look", max_item_count = 3, keyword_length = 3, option = { convert_case = true, loud = true } },
    { name = "nvim_lua", max_item_count = 7 },
    { name = "calc", max_item_count = 7 },
    { name = "path", max_item_count = 7 },
  },
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = "",
        nvim_lsp = "",
        spell = "",
        look = "",
      },
    }),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

-- cmp.setup.cmdline("/", {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = "buffer" },
--   },
-- })

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }),
})
