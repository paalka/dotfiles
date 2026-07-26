-- pastely
-- A soft, pastel dark theme ported from the VS Code "pastely" theme
-- (config/Code/extensions/pastely). Set with `:colorscheme pastely`.

vim.cmd.highlight 'clear'
if vim.g.syntax_on then
  vim.cmd.syntax 'reset'
end

vim.g.colors_name = 'pastely'
vim.o.termguicolors = true
vim.o.background = 'dark'

-- [[ Palette ]]
-- Core colors come straight from the VS Code theme; the UI shades below
-- (surfaces, borders, selections) are derived to round out a full editor.
local c = {
  bg = '#212121', -- editor.background
  bg_dark = '#1a1a1a', -- floats, sidebars, inactive surfaces
  bg_alt = '#262626', -- statusline / tabline / popups
  bg_high = '#2c2c2c', -- cursorline / current line surfaces
  bg_visual = '#3a3550', -- visual selection (tinted toward the accents)
  bg_sel = '#333048', -- pmenu selection
  border = '#3a3a3a',

  fg = '#dfdfdf', -- editor.foreground
  fg_dark = '#b6b6b6', -- secondary text
  gutter = '#5a5a5a', -- inactive line numbers
  comment = '#918c8c', -- comments / muted UI text

  pink = '#ffc9fb', -- keywords, storage, strings, tags
  lavender = '#b6b6fa', -- constants, accents (activityBarBadge)
  purple = '#ae98ff', -- types, classes
  purple2 = '#d4abf9', -- section headers
  blue = '#b6c2fa', -- functions
  lightblue = '#c0dbff', -- operators, punctuation
  cyan = '#89ddff', -- regex, escape sequences
  green = '#c3e88d', -- diff add, markdown headings
  orange = '#f78c6c', -- diff-ish accents, underlines

  red = '#ff638f', -- errors / invalid
  git_add = '#c3e88d',
  git_change = '#c792ea',
  git_delete = '#ff5370',

  none = 'NONE',
}

local function hi(groups)
  local set = vim.api.nvim_set_hl
  for name, spec in pairs(groups) do
    set(0, name, spec)
  end
end

hi {
  -- [[ Editor UI ]]
  Normal = { fg = c.fg, bg = c.bg },
  NormalNC = { fg = c.fg, bg = c.bg },
  NormalFloat = { fg = c.fg, bg = c.bg_dark },
  FloatBorder = { fg = c.border, bg = c.bg_dark },
  FloatTitle = { fg = c.purple2, bg = c.bg_dark, bold = true },
  ColorColumn = { bg = c.bg_high },
  Cursor = { fg = c.bg, bg = c.fg },
  CursorLine = { bg = c.bg_high },
  CursorColumn = { bg = c.bg_high },
  CursorLineNr = { fg = c.pink, bold = true },
  LineNr = { fg = c.gutter },
  SignColumn = { fg = c.gutter, bg = c.bg },
  Folded = { fg = c.comment, bg = c.bg_alt },
  FoldColumn = { fg = c.gutter, bg = c.bg },
  VertSplit = { fg = c.border },
  WinSeparator = { fg = c.border },
  Visual = { bg = c.bg_visual },
  VisualNOS = { bg = c.bg_visual },
  Search = { fg = c.bg, bg = c.pink },
  IncSearch = { fg = c.bg, bg = c.lavender },
  CurSearch = { fg = c.bg, bg = c.lavender },
  MatchParen = { fg = c.cyan, bold = true },
  NonText = { fg = c.gutter },
  Whitespace = { fg = c.border },
  SpecialKey = { fg = c.gutter },
  EndOfBuffer = { fg = c.bg },
  Conceal = { fg = c.comment },
  Directory = { fg = c.blue },
  Title = { fg = c.purple2, bold = true },
  ErrorMsg = { fg = c.red },
  WarningMsg = { fg = c.orange },
  MoreMsg = { fg = c.green },
  ModeMsg = { fg = c.fg_dark, bold = true },
  Question = { fg = c.green },
  QuickFixLine = { bg = c.bg_sel },
  WildMenu = { fg = c.bg, bg = c.pink },
  Pmenu = { fg = c.fg, bg = c.bg_alt },
  PmenuSel = { fg = c.fg, bg = c.bg_sel },
  PmenuSbar = { bg = c.bg_alt },
  PmenuThumb = { bg = c.border },
  StatusLine = { fg = c.fg, bg = c.bg_alt },
  StatusLineNC = { fg = c.comment, bg = c.bg_dark },
  TabLine = { fg = c.comment, bg = c.bg_dark },
  TabLineFill = { bg = c.bg_dark },
  TabLineSel = { fg = c.fg, bg = c.bg },

  -- [[ Syntax ]]
  Comment = { fg = c.comment, italic = true },

  Constant = { fg = c.fg },
  String = { fg = c.pink },
  Character = { fg = c.pink },
  Number = { fg = c.fg },
  Float = { fg = c.fg },
  Boolean = { fg = c.fg },

  Identifier = { fg = c.fg },
  Function = { fg = c.blue },

  Statement = { fg = c.pink },
  Conditional = { fg = c.pink },
  Repeat = { fg = c.pink },
  Label = { fg = c.pink },
  Operator = { fg = c.lightblue },
  Keyword = { fg = c.pink },
  Exception = { fg = c.pink },

  PreProc = { fg = c.lightblue },
  Include = { fg = c.pink },
  Define = { fg = c.pink },
  Macro = { fg = c.lightblue },
  PreCondit = { fg = c.lightblue },

  Type = { fg = c.purple },
  StorageClass = { fg = c.pink },
  Structure = { fg = c.purple },
  Typedef = { fg = c.purple },

  Special = { fg = c.cyan },
  SpecialChar = { fg = c.cyan },
  Tag = { fg = c.pink },
  Delimiter = { fg = c.lightblue },
  SpecialComment = { fg = c.comment, italic = true },
  Debug = { fg = c.red },

  Underlined = { underline = true },
  Bold = { bold = true },
  Italic = { italic = true },
  Ignore = { fg = c.gutter },
  Error = { fg = c.red },
  Todo = { fg = c.bg, bg = c.purple2, bold = true },

  -- [[ Diagnostics ]]
  DiagnosticError = { fg = c.red },
  DiagnosticWarn = { fg = c.orange },
  DiagnosticInfo = { fg = c.cyan },
  DiagnosticHint = { fg = c.lavender },
  DiagnosticOk = { fg = c.green },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.orange },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.cyan },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.lavender },
  DiagnosticVirtualTextError = { fg = c.red, bg = c.bg_alt },
  DiagnosticVirtualTextWarn = { fg = c.orange, bg = c.bg_alt },
  DiagnosticVirtualTextInfo = { fg = c.cyan, bg = c.bg_alt },
  DiagnosticVirtualTextHint = { fg = c.lavender, bg = c.bg_alt },

  -- [[ Diff / git ]]
  DiffAdd = { fg = c.git_add, bg = c.bg_alt },
  DiffChange = { fg = c.git_change, bg = c.bg_alt },
  DiffDelete = { fg = c.git_delete, bg = c.bg_alt },
  DiffText = { fg = c.fg, bg = c.bg_sel },
  Added = { fg = c.git_add },
  Changed = { fg = c.git_change },
  Removed = { fg = c.git_delete },
  diffAdded = { fg = c.git_add },
  diffChanged = { fg = c.git_change },
  diffRemoved = { fg = c.git_delete },

  -- [[ LSP ]]
  LspReferenceText = { bg = c.bg_sel },
  LspReferenceRead = { bg = c.bg_sel },
  LspReferenceWrite = { bg = c.bg_sel },
  LspInlayHint = { fg = c.gutter, bg = c.bg_alt },
  LspSignatureActiveParameter = { fg = c.pink, bold = true },
  LspCodeLens = { fg = c.comment, italic = true },

  -- [[ Spelling ]]
  SpellBad = { undercurl = true, sp = c.red },
  SpellCap = { undercurl = true, sp = c.orange },
  SpellLocal = { undercurl = true, sp = c.cyan },
  SpellRare = { undercurl = true, sp = c.lavender },
}

-- [[ Treesitter ]]
hi {
  ['@comment'] = { link = 'Comment' },
  ['@comment.error'] = { fg = c.red },
  ['@comment.warning'] = { fg = c.orange },
  ['@comment.note'] = { fg = c.lavender },
  ['@comment.todo'] = { link = 'Todo' },

  ['@variable'] = { fg = c.fg },
  ['@variable.builtin'] = { fg = c.fg, italic = true },
  ['@variable.parameter'] = { fg = c.fg },
  ['@variable.member'] = { fg = c.fg },

  ['@constant'] = { fg = c.fg },
  ['@constant.builtin'] = { fg = c.fg },
  ['@constant.macro'] = { fg = c.lightblue },

  ['@module'] = { fg = c.fg },
  ['@label'] = { fg = c.pink },

  ['@string'] = { fg = c.pink },
  ['@string.regexp'] = { fg = c.cyan },
  ['@string.escape'] = { fg = c.cyan },
  ['@string.special'] = { fg = c.cyan },
  ['@string.special.url'] = { fg = c.cyan, underline = true },
  ['@character'] = { fg = c.pink },
  ['@character.special'] = { fg = c.cyan },

  ['@number'] = { fg = c.fg },
  ['@number.float'] = { fg = c.fg },
  ['@boolean'] = { fg = c.fg },

  ['@function'] = { fg = c.blue },
  ['@function.builtin'] = { fg = c.blue },
  ['@function.call'] = { fg = c.blue },
  ['@function.macro'] = { fg = c.blue },
  ['@function.method'] = { fg = c.blue },
  ['@function.method.call'] = { fg = c.blue },
  ['@constructor'] = { fg = c.purple },

  ['@keyword'] = { fg = c.pink },
  ['@keyword.function'] = { fg = c.pink },
  ['@keyword.operator'] = { fg = c.lightblue },
  ['@keyword.return'] = { fg = c.pink },
  ['@keyword.conditional'] = { fg = c.pink },
  ['@keyword.repeat'] = { fg = c.pink },
  ['@keyword.import'] = { fg = c.pink },
  ['@keyword.exception'] = { fg = c.pink },
  ['@keyword.directive'] = { fg = c.lightblue },

  ['@operator'] = { fg = c.lightblue },
  ['@punctuation.delimiter'] = { fg = c.lightblue },
  ['@punctuation.bracket'] = { fg = c.lightblue },
  ['@punctuation.special'] = { fg = c.cyan },

  ['@type'] = { fg = c.purple },
  ['@type.builtin'] = { fg = c.purple },
  ['@type.definition'] = { fg = c.purple },
  ['@attribute'] = { fg = c.blue, italic = true },
  ['@property'] = { fg = c.fg },
  ['@field'] = { fg = c.fg },

  ['@tag'] = { fg = c.pink },
  ['@tag.builtin'] = { fg = c.pink },
  ['@tag.attribute'] = { fg = c.fg, italic = true },
  ['@tag.delimiter'] = { fg = c.lightblue },

  -- Markup (markdown, help, etc.)
  ['@markup.heading'] = { fg = c.green, bold = true },
  ['@markup.heading.1'] = { fg = c.green, bold = true },
  ['@markup.heading.2'] = { fg = c.green, bold = true },
  ['@markup.heading.3'] = { fg = c.green, bold = true },
  ['@markup.strong'] = { fg = c.orange, bold = true },
  ['@markup.italic'] = { fg = c.orange, italic = true },
  ['@markup.strikethrough'] = { strikethrough = true },
  ['@markup.underline'] = { underline = true },
  ['@markup.quote'] = { fg = c.comment, italic = true },
  ['@markup.math'] = { fg = c.cyan },
  ['@markup.link'] = { fg = c.blue },
  ['@markup.link.label'] = { fg = c.purple },
  ['@markup.link.url'] = { fg = c.cyan, underline = true },
  ['@markup.raw'] = { fg = c.git_change },
  ['@markup.raw.block'] = { fg = c.fg },
  ['@markup.list'] = { fg = c.lightblue },
  ['@markup.list.checked'] = { fg = c.green },
  ['@markup.list.unchecked'] = { fg = c.comment },

  ['@diff.plus'] = { fg = c.git_add },
  ['@diff.minus'] = { fg = c.git_delete },
  ['@diff.delta'] = { fg = c.git_change },
}

-- [[ Semantic tokens (LSP) ]]
hi {
  ['@lsp.type.class'] = { link = '@type' },
  ['@lsp.type.decorator'] = { link = '@attribute' },
  ['@lsp.type.enum'] = { link = '@type' },
  ['@lsp.type.enumMember'] = { link = '@constant' },
  ['@lsp.type.function'] = { link = '@function' },
  ['@lsp.type.interface'] = { link = '@type' },
  ['@lsp.type.macro'] = { link = '@function.macro' },
  ['@lsp.type.method'] = { link = '@function.method' },
  ['@lsp.type.namespace'] = { link = '@module' },
  ['@lsp.type.parameter'] = { link = '@variable.parameter' },
  ['@lsp.type.property'] = { link = '@property' },
  ['@lsp.type.struct'] = { link = '@type' },
  ['@lsp.type.type'] = { link = '@type' },
  ['@lsp.type.variable'] = { link = '@variable' },
}

-- [[ Plugin: gitsigns ]]
hi {
  GitSignsAdd = { fg = c.git_add },
  GitSignsChange = { fg = c.git_change },
  GitSignsDelete = { fg = c.git_delete },
}

-- [[ Plugin: telescope ]]
hi {
  TelescopeNormal = { fg = c.fg, bg = c.bg_dark },
  TelescopeBorder = { fg = c.border, bg = c.bg_dark },
  TelescopePromptNormal = { fg = c.fg, bg = c.bg_alt },
  TelescopePromptBorder = { fg = c.bg_alt, bg = c.bg_alt },
  TelescopePromptTitle = { fg = c.bg, bg = c.pink, bold = true },
  TelescopePreviewTitle = { fg = c.bg, bg = c.green, bold = true },
  TelescopeResultsTitle = { fg = c.bg_dark, bg = c.bg_dark },
  TelescopeSelection = { fg = c.fg, bg = c.bg_sel },
  TelescopeMatching = { fg = c.pink, bold = true },
}

-- [[ Plugin: which-key ]]
hi {
  WhichKey = { fg = c.pink },
  WhichKeyGroup = { fg = c.blue },
  WhichKeyDesc = { fg = c.fg },
  WhichKeySeparator = { fg = c.comment },
  WhichKeyFloat = { bg = c.bg_dark },
  WhichKeyBorder = { fg = c.border, bg = c.bg_dark },
}

-- [[ Plugin: mini.nvim ]]
hi {
  MiniStatuslineModeNormal = { fg = c.bg, bg = c.pink, bold = true },
  MiniStatuslineModeInsert = { fg = c.bg, bg = c.green, bold = true },
  MiniStatuslineModeVisual = { fg = c.bg, bg = c.lavender, bold = true },
  MiniStatuslineModeReplace = { fg = c.bg, bg = c.orange, bold = true },
  MiniStatuslineModeCommand = { fg = c.bg, bg = c.blue, bold = true },
  MiniStatuslineModeOther = { fg = c.bg, bg = c.cyan, bold = true },
  MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.bg_alt },
  MiniStatuslineFilename = { fg = c.comment, bg = c.bg_dark },
  MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.bg_alt },
  MiniStatuslineInactive = { fg = c.comment, bg = c.bg_dark },
}

-- [[ Plugin: blink.cmp ]]
hi {
  BlinkCmpMenu = { fg = c.fg, bg = c.bg_alt },
  BlinkCmpMenuBorder = { fg = c.border, bg = c.bg_alt },
  BlinkCmpMenuSelection = { bg = c.bg_sel },
  BlinkCmpLabel = { fg = c.fg },
  BlinkCmpLabelMatch = { fg = c.pink, bold = true },
  BlinkCmpKind = { fg = c.lavender },
  BlinkCmpDoc = { fg = c.fg, bg = c.bg_dark },
  BlinkCmpDocBorder = { fg = c.border, bg = c.bg_dark },
}

-- [[ Plugin: neo-tree ]]
hi {
  NeoTreeNormal = { fg = c.fg, bg = c.bg_dark },
  NeoTreeNormalNC = { fg = c.fg, bg = c.bg_dark },
  NeoTreeDirectoryName = { fg = c.blue },
  NeoTreeDirectoryIcon = { fg = c.blue },
  NeoTreeRootName = { fg = c.purple2, bold = true },
  NeoTreeFileName = { fg = c.fg },
  NeoTreeGitModified = { fg = c.git_change },
  NeoTreeGitAdded = { fg = c.git_add },
  NeoTreeGitDeleted = { fg = c.git_delete },
  NeoTreeGitUntracked = { fg = c.comment },
  NeoTreeIndentMarker = { fg = c.border },
}

-- [[ Plugin: todo-comments / mini-indentscope ]]
hi {
  MiniIndentscopeSymbol = { fg = c.border },
  IndentBlanklineChar = { fg = c.border },
  IblIndent = { fg = c.border },
  IblScope = { fg = c.gutter },
}
