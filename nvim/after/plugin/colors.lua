--
-- COLORS --
--

vim.opt.termguicolors = true
vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = true
vim.g.nord_enable_sidebar_background = true
vim.g.nord_uniform_diff_background = true

function SetColor(color)
    color = color or "nord" -- have a default value
    vim.cmd.colorscheme(color)
end

SetColor() -- run at startup
