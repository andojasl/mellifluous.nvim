local M = {}

function M.set(hl, colors)
    local root_fg = colors.dark_bg
    if Config.plugins.nvim_tree.show_root == true then
        root_fg = colors.fg3
    end

    hl.set('NvimTreeGitDeleted', { fg = colors.red })
    hl.set('NvimTreeGitDirty', { fg = colors.ui_orange })
    hl.set('NvimTreeGitIgnored', { fg = hl.get('Ignore').fg })
    hl.set('NvimTreeGitMerge', { fg = colors.ui_purple })
    hl.set('NvimTreeGitNew', { fg = colors.ui_blue })
    hl.set('NvimTreeGitRenamed', { fg = colors.ui_orange })
    hl.set('NvimTreeGitStaged', { fg = colors.ui_green })
    hl.set('NvimTreeNormal', {
        bg = (Config.transparent_background.file_tree and 'NONE')
            or (Config.flat_background.file_tree and hl.get('Normal').bg)
            or colors.dark_bg,
        fg = colors.fg2
    })
    hl.set('NvimTreeNormalNC', { link = 'NvimTreeNormal' })
    hl.set('NvimTreePopup', { link = 'NvimTreeNormal' })
    hl.set('NvimTreeSignColumn', { link = 'NvimTreeNormal' })
    hl.set('NvimTreeWinSeparator', {
        bg = hl.get('NvimTreeNormal').bg,
        fg = (Config.flat_background.line_numbers ~= Config.flat_background.file_tree
                and hl.get('NvimTreeNormal').bg) -- no separator if LineNr bg differs from this bg
            or (Config.flat_background.line_numbers and Config.flat_background.file_tree
                    and (Config.is_bg_dark and colors.bg4)
                        or colors.dark_bg2) -- stronger separator if both bg are flat
            or (Config.is_bg_dark and colors.bg3)
            or colors.dark_bg2
    })
    hl.set('NvimTreeIndentMarker', { fg = hl.get('Directory').fg })
    hl.set('NvimTreeEndOfBuffer', { bg = hl.get('NvimTreeNormal').bg, fg = hl.get('EndOfBuffer').fg })
    hl.set('NvimTreeFolderIcon', { fg = hl.get('Directory').fg })
    hl.set('NvimTreeRootFolder', { fg = root_fg })
end

return M
