local M = {}

function M.set(hl, colors)
    local root_fg = colors.fg3

    hl.set('NeoTreeGitConflict', { fg = colors.ui_purple })
    hl.set('NeoTreeGitDeleted', { fg = colors.red })
    hl.set('NeoTreeGitIgnored', { fg = hl.get('Ignore').fg })
    hl.set('NeoTreeGitModified', { fg = colors.ui_orange })
    hl.set('NeoTreeGitStaged', { fg = colors.ui_green })
    hl.set('NeoTreeGitRenamed', { fg = colors.ui_orange })
    hl.set('NeoTreeGitUntracked', { fg = colors.ui_orange })

    hl.set('NeoTreeNormal', {
        bg = (Config.transparent_background.file_tree and 'NONE') or (Config.flat_background.file_tree and hl.get(
            'Normal'
        ).bg) or colors.dark_bg,
        fg = colors.fg2,
    })
    hl.set('NeoTreeNormalNC', { link = 'NeoTreeNormal' })
    hl.set('NeoTreePopup', { link = 'NeoTreeNormal' })
    hl.set('NeoTreeWinSeparator', {
        bg = hl.get('NeoTreeNormal').bg,
        fg = (Config.flat_background.line_numbers ~= Config.flat_background.file_tree and hl.get('NeoTreeNormal').bg) -- no separator if LineNr bg differs from this bg
            or (
                Config.flat_background.line_numbers
                    and Config.flat_background.file_tree
                    and (Config.is_bg_dark and colors.bg4)
                or colors.dark_bg2
            ) -- stronger separator if both bg are flat
            or (Config.is_bg_dark and colors.bg3)
            or colors.dark_bg2,
    })
    hl.set('NeoTreeIndentMarker', { link = 'IndentBlanklineChar' })
    hl.set('NeoTreeEndOfBuffer', { bg = hl.get('NeoTreeNormal').bg, fg = hl.get('EndOfBuffer').fg })
    hl.set('NeoTreeFolderIcon', { fg = hl.get('Directory').fg })
    hl.set('NeoTreeRootName', { fg = root_fg })
    hl.set('NeoTreeStatusLine', { link = 'NeoTreeNormal' })
    hl.set('NeoTreeCursorLine', { link = 'CursorLine' })
    hl.set('NeoTreeCursorLineSign', { bg = hl.get('CursorLine').bg })
    hl.set('NeoTreeSignColumn', { link = 'NeoTreeNormal' })
end

return M
