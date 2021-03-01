-- Colorscheme using colorbuddy
-- with Treesitter, Typescript, LSP supported
-- colors from colorsx cloud (defunct website)
--
-- local Color, c, Group, g, s = require"colorbuddy".setup()

local colors = require"colors"
local s = require'style'

local group = require'group'
-- local Group = colorbuddy_group.Group
-- local log_to_file = function(logfile)
--   return function(log_value)
--     local file = io.open(logfile, "a")
--     if not file then
--       file:close()
--       return
--     end

--     file:write(log_value .. "\n")
--     file:close()
--   end
-- end

-- local log = log_to_file("boo-colorscheme.log")

-- Merge a list of list-like tables togeter
-- { {'x'}, {'y'} } -> {'x', 'y'}
local merge = function(list)
  local acc = {}

  for _, result in ipairs(list) do vim.list_extend(acc, result) end

  return acc
end

-- param groups table list of Groups to apply the highlights
local highlight_to_groups = function(highlight)
  -- param highlight table 3 element table { fg colorbuddy.Color, bg colorbuddy.Color, styles colorbuddy.Styles }
  return function(groups)
    local acc = {}

    for _, name in ipairs(groups) do
      table.insert(acc, {name, highlight[1], highlight[2], highlight[3]})
    end

    return acc
  end
end

-- Cloud colors
local cloud = function()
  return {
    "#222827",
    "#d5a8e4",
    "#9c75dd",
    "#9898ae",
    "#654a96",
    "#625566",
    "#a9d1df",
    "#e6ebe5",
    "#5d6f74",
    "#cd749c",
    "#63b0b0",
    "#c0c0dd",
    "#5786bc",
    "#3f3442",
    "#849da2",
    "#d9d6cf",
  }
end


local vimscript = function(c)
  return {
    {"vimcommand", c.cloud4},
    {"vimmap", c.cloud4},
    {"vimbracket", c.cloud10},
    {"vimmapmodkey", c.cloud6},
    {"vimnotation", c.cloud6},
    {"vimmaplhs", c.cloud10},
    {"vimiscommand", c.cloud10:light()},
    {"vimFilter", c.cloud7},
    {"vimMapRhs", c.cloud15:dark(.1)},
    {"vimMapRhsExtend", c.cloud15:dark(.1)},

    {"vimlet", c.cloud4:dark()},
    {"vimnotfunc", c.cloud4:dark()},
    {"vimAutoCmdSfxList", c.cloud6},
    {"vimUserFunc", c.cloud10},
    {"vimSetEqual", c.cloud6},
  }
end

local lsp = function(c)
  return {
    {"LspDiagnosticsDefaultHint", c.cloud13:saturate(.05):light(), c.cloud13:dark(.9)},
    {"LspDiagnosticsDefaultError", c.cloud1:dark():saturate(.5), c.cloud1:dark(.7):saturate(.1)},
    {"LspDiagnosticsDefaultWarning", c.cloud6, c.cloud6:dark(.6):saturate(.2):light(.001)},
    {"LspDiagnosticsDefaultInformation", c.fg},
  }
end

local ale = function()
  -- Clear ALEWarning
  -- Clear ALEError
  vim.cmd("highlight clear ALEWarning")
  vim.cmd("highlight clear ALEError")
end

local telescope = function(c)
  return {
    {"TelescopeBorder", c.cloud8:dark(.3)},
    {"TelescopeNormal", c.cloud0:light(.3)},
    {"TelescopePromptPrefix", c.cloud10:dark(.2)},

    {"TelescopeSelection", c.cloud10:light(), c.cloud8:dark(.2), s.bold},
    {"TelescopeMatching", c.cloud4:light()},
  }
end

local typescript = function(c)
  -- {"typescriptbraces", c.cloud14:dark()},

  -- tsx
  return {
    {"tsxJsBlock", c.cloud8:light()},
    {"tsxclosetag", c.cloud8},
    {"tsxelseoperator", c.cloud10:dark(.2)},
    {"tsxclosetagname", c.cloud10},

    {"tsxclosetag", c.cloud8:dark()},

    {"tsxtypes", c.cloud10:light(), c.none, s.none},
    {"tsxtag", c.cloud8},

    {"typescriptAliasDeclaration", c.cloud8},
    {"typescriptObjectLiteral", c.cloud8},
    {"typescriptBinaryOp", c.cloud8},

    {"typescriptParenExp", c.cloud8},
    -- Actually used as this? not sure if case sensitive
    {"typescriptparenexp", c.cloud10},

    {"typescripttypeannotation", c.cloud3:dark(.35)},

    {"typescriptEnum", c.cloud10},
    {"typescriptString", c.cloud10:light(.3)},
    {"typescriptProp", c.cloud10},
    {"typescriptUnion", c.cloud8:dark()},

    {"typescriptObjectColon", c.cloud3:dark(.35)},
    {"typescriptObjectSpread", c.cloud14:dark(.1)},
    {"typescriptObjectType", c.cloud8:dark()},

    {"typescriptRestOrSpread", c.cloud8:dark()},

    {"typescriptInterfaceTypeParameter", c.cloud8:dark()},
    {"typescriptInterfaceName", c.cloud10},

    {"typescriptParens", c.cloud8},
    {"typescriptTernaryOp", c.cloud8},
    {"typescriptParenthesizedType", c.cloud10:dark(.2)},
    {"typescriptIdentifierName", c.cloud10},

    {"typescriptMemberOptionality", c.cloud10:light()},
    {"typescriptMember", c.cloud10:light(.2)},

    {"typescriptGlobal", c.cloud7},
    {"typescriptGenericCall", c.cloud8},
    {"typescript1", c.cloud6:dark():saturate(.1)},

    {"typescriptAssign", c.cloud6:dark():saturate(.1)},
    {"typescriptbraces", c.cloud8:dark(.2)},
    {"typescriptendcolons", c.cloud10:light()},

    {"typescriptFuncCallArg", c.cloud6},
    {"typescriptTypeBrackets", c.cloud8:dark()},
    {"typescriptTypeAnnotation", c.cloud8},
    {"typescriptTypeArguments", c.cloud8},
    {"typescriptTypeReference", c.cloud10},
    {"typescriptTypeCast", c.cloud8},
    {"typescriptFuncType", c.cloud10},

    {"typescriptUnaryOp", c.cloud4:light(.3), c.none, s.bold},

    {"typescriptaliasdeclaration", c.cloud10},
  }
end

local markdown = function(c)
  local to_groups = highlight_to_groups({c.cloud5:dark(), c.cloud5:light()})
  local delimiters = to_groups({
    "markdownH1Delimiter",
    "markdownH2Delimiter",
    "markdownH3Delimiter",
    "markdownH4Delimiter",
    "markdownH5Delimiter",
    "markdownH6Delimiter",
  })

  return merge({
    delimiters,
    {
      {"markdownh1", c.cloud6:light():saturate(.7), c.cloud0:dark(), s.bold},
      {"markdownh2", c.cloud6:saturate(.7), c.cloud0:dark(), s.bold},
      {"markdownh3", c.cloud6:dark(), c.cloud0:dark(), s.bold},
      {"markdownh4", c.cloud6:dark(), c.cloud0:dark(), s.bold},
      {"markdownh5", c.cloud6:dark(), c.cloud0:dark(), s.bold},

      {"markdownCodeDelimiter", c.cloud8:dark(), c.cloud0:dark(.1)},
      {"markdownCode", c.cloud4, c.cloud0:dark(.1)},
      {"markdownUrl", c.cloud14},
      {"markdownLinkText", c.cloud10},

      {"markdownLinkTextDelimiter", c.cloud8},
      {"markdownLinkDelimiter", c.cloud8},
    },
  })
end

local treesitter = function(c)
  local error = {"TSError"}

  local punctuation = {"TSPunctDelimiter", "TSPunctBracket", "TSPunchSpecial"}

  local constants = {"TSConstant", "TsConstBuiltin", "TSConstMacro"}

  local constructors = {"TSConstructor"}

  local string = {"TSStringRegex", "TSString", "TSStringEscape"}

  local boolean = {"TSBoolean"}

  local functions = {"TSFunction", "TSFuncBuiltin", "TSFuncMacro"}

  local methods = {"TSMethod"}

  local fields = {"TSField", "TSProperty"}

  local number = {"TSNumber", "TSFloat"}

  local parameters = {"TSParameter", "TSParameterReference"}

  local operators = {"TSOperator"}

  local forwords = {"TSConditional", "TSRepeat"}

  local keyword = {"TSKeyword", "TSKeywordOperator"}

  local types = {"TSType", "TSTypeBuiltin"}

  local labels = {"TSLabel"}

  local namespaces = {"TSNamespace"}

  local includes = {"TSInclude"}

  local variables = {"TSVariable", "TSVariableBuiltin"}

  local tags = {"TSTag", "TSTagDelimiter"}

  local text = {"TSText", "TSStrong", "TSEmphasis", "TSUnderline", "TSTitle", "TSLiteral", "TSURI"}

  local groups = {
    {error, c.cloud1:light(), c.cloud9:dark(.5), s.none},
    {punctuation, c.cloud3:dark(.35)},
    {constants, c.cloud5:light()},
    {string, c.cloud10:light():light():saturate(.25)},
    {boolean, c.cloud2:light()},
    {functions, c.cloud14},
    {methods, c.cloud14:light(.1), c.none, s.italic},
    {fields, c.cloud8:light()},
    {number, c.cloud6:light()},
    {parameters, c.cloud6:dark()},
    {operators, c.cloud3:dark():dark()},
    {forwords, c.cloud8:saturate(.1):light(), c.none},
    {keyword, c.cloud4:dark(.2):saturate(.01):light(.2), c.none, s.italic},
    {constructors, c.cloud10},
    {types, c.cloud10},
    {includes, c.cloud4},
    {labels, c.cloud4:light()},
    {namespaces, c.cloud14:light()},
    {variables, c.cloud10:light(.2)},
    {tags, c.cloud10:light()},
    {text, c.fg},
  }

  local highlights = {}

  -- Apply grouping to each color group
  for _, group in ipairs(groups) do
    highlights = merge({highlights, highlight_to_groups({group[2], group[3], group[4]})(group[1])})
  end

  return merge({
    highlights,
    {

      -- {"TSPunctBracket", c.blue},
      {"TSPunctDelimiter", c.cloud3:dark():dark():saturate(.1)},
      {"TSTagDelimiter", c.cloud8:dark(.15)},

      {"TSPunctSpecial", c.cloud12:dark():dark():light(.3)},
      {"TSVariableBuiltin", c.cloud6:dark(), c.none, s.bold},

      -- null
      {"TSConstBuiltin", c.cloud6:dark(.3), c.none, s.bold},

      {"TSTypeBuiltin", c.cloud10:dark(.2), c.none, s.bold},
      {"TSFuncBuiltin", c.cloud8:light(.1), c.none, s.bold},

      {"TSVariableBuiltin", c.cloud12:dark(.2)},

      {"TSField", c.cloud8},

      -- {"TSTitle", c.cloud4},
      -- {"TSStrong", c.cloud4, c.none, s.bold},
    },
  })
end


--[[ How this works:
--  We create a data structure that is a list of 4 item tables
--  { { group, fg, bg, styles }, ... }
--]]
local colorscheme = function(c)
  local vim_groups = {
    {"Normal", c.fg:dark(.01), c.bg:light(.01)},

    -- Conceal
    {"Conceal", c.cloud3:light()},

    {"VertSplit", c.cloud0},

    {"Function", c.cloud8, c.none, s.bold},

    {"Error", c.cloud9, c.none, s.bold},
    {"ErrorMsg", c.cloud1:dark():saturate(.1), c.cloud1:dark(.7):saturate(.1):dark(.05)},

    {"WarningMsg", c.cloud4:light(.3), c.cloud12:dark(.3)},
    {"Exception", c.cloud9, c.none, s.NONE},

    {"Boolean", c.cloud2:dark(), c.none, s.NONE},
    {"Character", c.cloud14, c.none, s.NONE},
    {"Comment", c.cloud3:dark(), c.bg:light(.04), s.NONE},
    {"Conditional", c.cloud10, c.none, s.NONE},
    {"Constant", c.cloud4, c.none, s.NONE},

    {"Float", c.cloud4, c.none, s.NONE},

    {"NormalFloat", c.cloud6, c.cloud0:dark(.4)},

    -- Search
    {"IncSearch", c.cloud10:light(), c.cloud10:dark(.5), s.italic},
    {"Search", c.cloud10, c.cloud10:dark(.8)},

    -- Numbers
    {"Number", c.cloud15, c.none, s.NONE},

    {"Define", c.cloud10, c.none, s.NONE},

    {"Delimiter", c.cloud6, c.none, s.NONE},

    {"Directory", c.cloud4},

    {"Function", c.cloud8},

    -- Folds
    {"Folded", c.cloud4:dark(.1)},
    {"FoldColumn", c.cloud4:light()},

    -- Diff
    {"DiffAdd", c.none, c.cloud10},
    {"DiffChange", c.none, c.cloud12},
    {"DiffDelete", c.none, c.cloud9},
    {"DiffText", c.none, c.cloud3},

    {"Identifier", c.cloud2, c.none, s.NONE},
    {"Include", c.cloud10, c.none, s.NONE},

    {"Keyword", c.cloud4, c.none, s.italic},

    {"Label", c.cloud10, c.none, s.italic},

    {"Operator", c.cloud12:dark(), c.none, s.NONE},

    {"PreProc", c.cloud10, c.none, s.NONE},

    {"Repeat", c.cloud12:dark(), c.none, s.NONE},

    {"Statement", c.cloud10, c.none, s.NONE},
    {"StorageClass", c.cloud10, c.none, s.NONE},
    {"String", c.cloud14, c.none, s.NONE},
    {"Structure", c.cloud10, c.none, s.NONE},
    {"Tag", c.cloud4, c.none, s.NONE},

    {"Title", c.cloud4, c.none},

    {"Todo", c.cloud13, c.none, s.NONE},

    {"Type", c.cloud10:light(), c.none, s.italic},
    {"Typedef", c.cloud10, c.none, s.NONE},

    -- Side Column
    {"CursorColumn", c.cloud1, c.none, s.NONE},
    {"LineNr", c.cloud10, c.none, s.NONE},
    {"CursorLineNr", c.cloud5, c.none, s.NONE},
    {"Line", c.cloud12, c.none, s.bold},
    {"SignColumn", c.none, c.none, s.NONE},

    {"ColorColumn", c.none, c.cloud1},
    {"Cursor", c.cloud0, c.cloud4},
    {"CursorLine", c.none, c.cloud0},
    {"iCursor", c.cloud0, c.cloud4},

    {"EndOfBuffer", c.cloud3, c.none},

    {"MatchParen", c.none, c.cloud13:dark()},
    {"NonText", c.bg:light(), c.none},

    -- Popup Menu
    {"PMenu", c.cloud2:light(), c.cloud5:dark(.3)},
    {"PmenuSbar", c.cloud4, c.cloud0:dark()},
    {"PMenuSel", c.cloud2:saturate(.9):light(.2), c.cloud0:dark(.7)},
    {"PmenuThumb", c.cloud8, c.cloud3},

    -- Special
    {"Special", c.cloud4, c.none, s.NONE},
    {"SpecialChar", c.cloud13, c.none, s.NONE},
    {"SpecialKey", c.cloud13},
    {"SpecialComment", c.cloud8, c.none, s.NONE},

    -- Spell
    {"SpellBad", c.cloud11, c.none},
    {"SpellCap", c.cloud13, c.none},
    {"SpellLocal", c.cloud5, c.none},
    {"SpellRare", c.cloud6, c.none},

    -- Statusline
    {"StatusLine", c.cloud10, c.cloud8:dark(.2)},
    {"StatusLineNC", c.cloud4, c.cloud8:dark(.3)},

    -- Tabline
    {"TabLine", c.cloud2, c.cloud0:dark()},
    {"TabLineSel", c.cloud10:light(), c.cloud13, s.bold},
    {"TabLineFill", c.cloud2, c.cloud0:dark()},

    {"Question", c.cloud10, c.none, s.bold},

    -- Visual
    {"Visual", c.cloud10, c.cloud13:dark(.2)},
    {"VisualNOS", c.cloud2, c.cloud1},
  }

  -- M:ale()

  return merge({
    vim_groups,
    lsp(c),
    treesitter(c),
    typescript(c),
    markdown(c),
    vimscript(c),
    telescope(c),
  })
end
-- Non-functional WIP
local save_vim_colorscheme = function(groups)
  -- local groups = require'colorbuddy.group'.list_groups()
  -- require"colorbuddy.group".save_vim_colorscheme("boo", "colors/boo.vim",
  --                                                require"colorbuddy.group".generate_vim_highlights(g))
  --
 
  -- local colorscheme = [[
  --   " boo-colorscheme-nvim
  -- ]]

  -- for _, group in ipairs(groups) do 

  --   highlights = string.format(" %s %s %s", group. 
  -- end
end

local M = {}

M.apply = function(c)
  vim.cmd(
      string.format('highlight %s guifg=%s guibg=%s gui=%s'
          , c[1]
          , c[2]
          , c[3]
          , c[4]
      )
  )
end

-- Use this function in your config
M.use = function()
  vim.g.termguicolors = true
  -- vim.cmd("hi! clear")
  local colors = M.setup()

  for _, group in ipairs(colors) do
    local check_none = function(none_resp)
      return function(x)
        return not x and none_resp or x
      end
    end

    local cNone = check_none("none")
    local sNone = check_none(s.none)

    M.apply({group[1], cNone(group[2]), cNone(group[3]), sNone(group[4])})
  end
end

M.setup = function()
 local cloud_map = cloud()
  local color_map = {
    none = 'none'
  }

  -- cloud0 to cloud16 for all the available colors.
  for i, color in ipairs(cloud_map) do 
    color_map["cloud" .. i - 1] = colors(color) 
  end

  color_map["fg"] = colors("#e4dcec")
  color_map["bg"] = colors("#111113")

  return colorscheme(color_map)
end

return M
