-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ~/.config/nvim/lua/config/autocmds.lua

local function clear_backgrounds()
  local hl_groups = {
    "Normal",
    "NormalNC",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "EndOfBuffer",
    "MsgArea",
    "Folded",
    "FoldColumn",
    "LineNr",
    "CursorLineNr",
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "NeoTreeWinSeparator",
    "FloatBorder",
    "NormalFloat",
    
    -- Explicitly target the dashboard layout layers
    "SnacksDashboardNormal",
    "SnacksDashboardHeader",
    "SnacksDashboardFooter",
    "SnacksDashboardDesc",
    "SnacksDashboardKey",
    "SnacksDashboardIcon",
  }

  for _, group in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  end
end

-- 1. Run when the colorscheme initializes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = clear_backgrounds,
})

-- 2. Run whenever the startup menu or a new window initializes
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = { "*", "snacks_dashboard" },
  callback = clear_backgrounds,
})
