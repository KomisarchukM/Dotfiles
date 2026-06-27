-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

-- Tame the diagnostic noise
vim.diagnostic.config({
  -- Only show the floating text at the end of the line for hard errors
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  -- Show warning/error icons in the left gutter, but hide hints/info
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  -- Never update diagnostics while you are actively typing
  update_in_insert = false, 
})
