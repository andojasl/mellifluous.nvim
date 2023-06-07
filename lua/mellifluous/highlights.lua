return function(colors)
    ---@diagnostic disable: undefined-global
    local lush = require('lush')
    local hsl = lush.hsl
    local config = require('mellifluous').config
    local change_color = require('mellifluous.utils.change_color')
    local shader = require'mellifluous.colors.shader'
    local shade_recipes = shader.get_shade_recipes(config.is_bg_dark)

    return lush(function()
        return {
            Normal       {
                bg = (config.transparent_background.enabled and 'NONE')
                    or colors.bg.hex,
                fg = colors.fg.hex
            }, -- Normal text
            NormalNC     {
                bg = (config.dim_inactive and colors.dark_bg.hex)
                    or (config.transparent_background and 'NONE')
                    or Normal.bg
            }, -- normal text in non-current windows
            ColorColumn  { bg = colors.dark_bg.hex }, -- Columns set with 'colorcolumn'
            Conceal      { fg = colors.fg5.hex }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
            Cursor       { bg = colors.other_keywords.hex, fg = colors.bg.hex }, -- Character under the cursor
            lCursor      { Cursor }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
            CursorIM     { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
            CursorColumn { bg = colors.bg2.hex }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
            CursorLine   {
                bg = (config.transparent_background.cursor_line and 'NONE')
                    or colors.bg2.hex
            }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
            Directory    { fg = colors.functions.hex }, -- Directory names (and other special names in listings)
            DiffAdd      { bg = change_color.get_lower_contrast(colors.green, 45):desaturated(30).hex }, -- Diff mode: Added line |diff.txt|
            DiffDelete   { bg = change_color.get_lower_contrast(colors.red, 45):desaturated(35).hex }, -- Diff mode: Deleted line |diff.txt|
            DiffChange   { bg = change_color.get_lower_contrast(colors.orange, 50):desaturated(70).hex }, -- Diff mode: Changed line |diff.txt|
            DiffText     { bg = change_color.get_lower_contrast(colors.orange, 40):desaturated(40).hex }, -- Diff mode: Changed text within a changed line |diff.txt|
            EndOfBuffer  { fg = colors.bg.hex }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
            TermCursor   { Cursor }, -- Cursor in a focused terminal
            TermCursorNC { bg = colors.fg5.hex }, -- Cursor in an unfocused terminal
            ErrorMsg     { fg = colors.red.hex }, -- Error messages on the command line
            VertSplit    {
                fg = colors.fg5.hex,
                bg = (config.dim_inactive and NormalNC.bg)
                    or (config.transparent_background.enabled and 'NONE')
                    or Normal.bg
            }, -- Column separating vertically split windows
            Folded       { bg = colors.bg3.hex, fg = colors.fg3.hex, gui = config.styles.folds }, -- Line used for closed folds
            FoldColumn   { Normal }, -- 'foldcolumn'
            LineNr       {
                fg = colors.fg4.hex,
                bg = (config.transparent_background.enabled and 'NONE')
                    or (config.flat_background.line_numbers and Normal.bg)
                    or colors.dark_bg.hex
            }, -- Line number for ':number' and ':#' commands, and when 'number' or 'relativenumber' option is set.
            SignColumn   { LineNr }, -- Column where |signs| are displayed
            IncSearch    { bg = colors.other_keywords.hex, fg = colors.bg.hex }, -- 'incsearch' highlighting; also used for the text replaced with ':s///c'
            Substitute   { IncSearch }, -- |:substitute| replacement text highlighting
            CursorLineNr {
                bg = (config.flat_background.cursor_line_number and LineNr.bg)
                     or (config.transparent_background.enabled and 'NONE')
                    or shader.apply_shade(shade_recipes.dark_bg, CursorLine.bg).hex,
                fg = LineNr.fg
            }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
            MatchParen   { bg = colors.bg4.hex, fg = colors.main_keywords.hex }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
            ModeMsg      { fg = colors.fg3.hex }, -- 'showmode' message (e.g., '-- INSERT -- ')
            MsgArea      { Normal }, -- Area for messages and cmdline
            MsgSeparator { VertSplit }, -- Separator for scrolled messages, `msgsep` flag of 'display'
            MoreMsg      { fg = colors.other_keywords.hex }, -- |more-prompt|
            NonText      { Conceal }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
            Title        { fg = colors.other_keywords.hex }, -- Titles for output from ':set all', ':autocmd' etc.
            NormalFloat  {
                bg = (config.transparent_background.floating_windows and 'NONE')
                    or (config.flat_background.floating_windows and Normal.bg)
                    or colors.bg3.hex
            }, -- Normal text in floating windows.
            FloatBorder  {
                bg = NormalFloat.bg,
                fg = ((config.transparent_background.floating_windows
                        or config.flat_background.floating_windows)
                            and colors.fg4.hex)
                    or NormalFloat.bg
            },
            FloatTitle   { bg = NormalFloat.bg, fg = colors.comments.hex },
            FloatShadow  { bg = colors.dark_bg.hex },
            Pmenu        { bg = colors.bg4.hex, fg = config.is_bg_dark and colors.fg3.hex or colors.fg4.hex }, -- Popup menu: Normal item.
            PmenuSel     { bg = config.is_bg_dark and colors.fg5.hex or colors.dark_bg.hex }, -- Popup menu: Selected item.
            PmenuSbar    { bg = colors.bg3.hex }, -- Popup menu: Scrollbar.
            PmenuThumb   { bg = colors.fg5.hex }, -- Popup menu: Thumb of the scrollbar.
            Question     { fg = colors.other_keywords.hex }, -- |hit-enter| prompt and yes/no questions
            QuickFixLine { Normal }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
            Search       { bg = colors.bg4.hex, fg = colors.fg.hex }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
            SpecialKey   { fg = colors.other_keywords.hex }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
            SpellBad     { fg = colors.red.hex }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
            SpellCap     { fg = colors.orange.hex }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
            SpellLocal   { fg = colors.orange.hex }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
            SpellRare    { fg = colors.orange.hex }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
            StatusLine   {
                bg = (config.transparent_background.status_line and 'NONE')
                    or colors.bg4.hex,
                fg = colors.fg2.hex
            }, -- Status line of current window
            StatusLineNC {
                bg = (config.transparent_background.status_line and 'NONE')
                    or colors.bg2.hex,
                fg = colors.fg4.hex
            }, -- Status lines of not-current windows. Note: If this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
            TabLine      { bg = StatusLine.bg, fg = colors.fg3.hex }, -- Tab pages line, not active tab page label
            TabLineFill  { TabLine }, -- Tab pages line, where there are no labels
            TabLineSel   { bg = colors.bg2.hex, fg = colors.fg2.hex }, -- Tab pages line, active tab page label
            Visual       { bg = config.is_bg_dark and colors.bg4.hex or colors.dark_bg2.hex }, -- Visual mode selection
            VisualNOS    { bg = colors.bg3.hex }, -- Visual mode selection when vim is 'Not Owning the Selection'.
            WarningMsg   { fg = colors.red.hex }, -- Warning messages
            Whitespace   { fg = colors.fg5.hex }, -- 'nbsp', 'space', 'tab' and 'trail' in 'listchars'
            WinSeparator { VertSplit }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
            WildMenu     { PmenuSel }, -- Current match in 'wildmenu' completion

            -- Common vim syntax groups used for all kinds of code and markup.
            -- Commented-out groups should chain up to their preferred (*) group
            -- by default.
            --
            -- See :h group-name
            --
            -- Uncomment and edit if you want more specific syntax highlighting.

            Comment        { fg = colors.comments.hex, gui = config.styles.comments }, -- Any comment

            Constant       { fg = colors.constants.hex }, -- (*) Any constant
            String         { fg = colors.strings.hex, gui = config.styles.strings }, --   A string constant: 'this is a string'
            Character      { fg = String.fg }, --   A character constant: 'c', '\n'
            Number         { Constant, gui = config.styles.numbers }, --   A number constant: 234, 0xff
            Boolean        { Constant, gui = config.styles.booleans }, --   A boolean constant: TRUE, false
            Float          { Constant, gui = config.styles.numbers }, --   A floating point constant: 2.3e10

            Identifier     { fg = colors.fg.hex, gui = config.styles.variables }, -- (*) Any variable name
            Function       { fg = colors.functions.hex, gui = config.styles.functions }, --   Function name (also: methods for classes)

            Statement      { fg = colors.other_keywords.hex }, -- (*) Any statement
            Conditional    { fg = colors.main_keywords.hex, gui = config.styles.conditionals }, --   if, then, else, endif, switch, etc.
            Repeat         { fg = colors.main_keywords.hex, gui = config.styles.loops }, --   for, do, while, etc.
            Label          { fg = colors.main_keywords.hex, gui = config.styles.keywords }, --   case, default, etc.
            Operator       { fg = config.is_bg_dark and colors.operators.hex or colors.fg3.hex, gui = config.styles.operators }, --   'sizeof', '+', '*', etc.
            Keyword        { fg = colors.other_keywords.hex }, --   any other keyword
            Exception      { fg = colors.other_keywords.hex }, --   try, catch, throw

            PreProc        { fg = colors.functions.hex }, -- (*) Generic Preprocessor
            Include        { PreProc }, --   Preprocessor #include
            Define         { PreProc }, --   Preprocessor #define
            Macro          { PreProc }, --   Same as Define
            PreCondit      { PreProc }, --   Preprocessor #if, #else, #endif, etc.

            Type           { fg = colors.types.hex, gui = config.styles.types }, -- (*) int, long, char, etc.
            StorageClass   { Type }, --   static, register, volatile, etc.
            Structure      { Type }, --   struct, union, enum, etc.
            Typedef        { Type }, --   A typedef

            Special        { fg = colors.other_keywords.hex }, -- (*) Any special symbol
            SpecialChar    { Special }, --   Special character in a constant
            Tag            { Special }, --   You can use CTRL-] on this
            Delimiter      { Operator }, --   Character that needs attention
            SpecialComment { Special }, --   Special things inside a comment (e.g. '\n')
            Debug          { Special }, --   Debugging statements

            Underlined     { gui = 'underline', fg = colors.fg3.hex }, -- Text that stands out, HTML links
            Bold { bold = config.bold },
            Italic { italic = config.italic },
            Ignore         { fg = colors.fg5.hex }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
            Error          { fg = colors.red.hex }, -- Any erroneous construct
            Todo           { bg = colors.strings.hex, fg = colors.bg.hex }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

            -- These groups are for the native LSP client and diagnostic system. Some
            -- other LSP clients may use these groups, or use their own. Consult your
            -- LSP client's documentation.

            -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
            --
            LspReferenceText            { bg = colors.bg3.hex } , -- Used for highlighting 'text' references
            LspReferenceRead            { LspReferenceText } , -- Used for highlighting 'read' references
            LspReferenceWrite           { LspReferenceText } , -- Used for highlighting 'write' references
            LspCodeLens                 { bg = colors.bg2.hex } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
            LspCodeLensSeparator        { fg = colors.fg5.hex } , -- Used to color the seperator between two or more code lens.
            LspSignatureActiveParameter { bg = colors.bg4.hex } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

            -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
            --
            DiagnosticError            { fg = colors.red.hex } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
            DiagnosticWarn             { fg = colors.orange.hex } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
            DiagnosticInfo             { fg = colors.blue.hex } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
            DiagnosticHint             { fg = colors.purple.hex } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
            DiagnosticVirtualTextError { fg = DiagnosticError.fg, bg = (config.transparent_background.enabled and 'NONE') or colors.bg3.hex } , -- Used for 'Error' diagnostic virtual text.
            DiagnosticVirtualTextWarn  { fg = DiagnosticWarn.fg, bg = (config.transparent_background.enabled and 'NONE') or colors.bg3.hex } ,  -- Used for 'Warn' diagnostic virtual text.
            DiagnosticVirtualTextInfo  { fg = DiagnosticInfo.fg, bg = (config.transparent_background.enabled and 'NONE') or colors.bg3.hex } ,  -- Used for 'Info' diagnostic virtual text.
            DiagnosticVirtualTextHint  { fg = DiagnosticHint.fg, bg = (config.transparent_background.enabled and 'NONE') or colors.bg3.hex } ,  -- Used for 'Hint' diagnostic virtual text.
            DiagnosticUnderlineError   { gui = 'underline' } , -- Used to underline 'Error' diagnostics.
            DiagnosticUnderlineWarn    { gui = 'underline' } , -- Used to underline 'Warn' diagnostics.
            DiagnosticUnderlineInfo    { gui = 'underline' } , -- Used to underline 'Info' diagnostics.
            DiagnosticUnderlineHint    { gui = 'underline' } , -- Used to underline 'Hint' diagnostics.
            -- DiagnosticFloatingError    { } , -- Used to color 'Error' diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
            -- DiagnosticFloatingWarn     { } , -- Used to color 'Warn' diagnostic messages in diagnostics float.
            -- DiagnosticFloatingInfo     { } , -- Used to color 'Info' diagnostic messages in diagnostics float.
            -- DiagnosticFloatingHint     { } , -- Used to color 'Hint' diagnostic messages in diagnostics float.
            DiagnosticSignError        { fg = DiagnosticError.fg, bg = LineNr.bg } , -- Used for 'Error' signs in sign column.
            DiagnosticSignWarn         { fg = DiagnosticWarn.fg, bg = LineNr.bg } , -- Used for 'Warn' signs in sign column.
            DiagnosticSignInfo         { fg = DiagnosticInfo.fg, bg = LineNr.bg } , -- Used for 'Info' signs in sign column.
            DiagnosticSignHint         { fg = DiagnosticHint.fg, bg = LineNr.bg } , -- Used for 'Hint' signs in sign column.
        }
    end)
end

