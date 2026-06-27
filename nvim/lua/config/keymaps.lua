-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ~/.config/nvim/lua/config/keymaps.lua

local function run_cpp()
  -- Ensure we are in a C++ file
  if vim.bo.filetype ~= "cpp" then
    vim.notify("Not a C++ file!", vim.log.levels.WARN)
    return
  end

  local file = vim.fn.expand("%")
  local output_bin = vim.fn.expand("%:p:r")

  -- 1. Save the file automatically
  vim.cmd("w")

  -- 2. Build the command string
  local execution_str = string.format(
    "clang++ -std=c++17 '%s' -o '%s' && '%s'; echo; echo '---------------------------------'; read -p 'Process finished. Press ENTER to close...' dummy",
    file,
    output_bin,
    output_bin
  )

  -- 3.  Open a new horizontal split with a completely NEW, empty buffer
  -- 'botright' forces it to the bottom, '12' sets the height, 'new' creates the empty buffer
  vim.cmd("botright 12new")

  -- 4. Spawn the native terminal strictly inside this new isolated buffer
  vim.fn.termopen({ "sh", "-c", execution_str })

  -- 5. Drop straight into insert mode for inputs
  vim.cmd("startinsert")
end

-- Map the keybind
vim.keymap.set("n", "<leader>r", run_cpp, { desc = "Compile and Run C++", noremap = true, silent = true })


vim.keymap.set("n", "<leader>td", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify("Diagnostics Hidden", vim.log.levels.WARN)
  else
    vim.diagnostic.enable(true)
    vim.notify("Diagnostics Shown", vim.log.levels.INFO)
  end
end, { desc = "Toggle Diagnostics / Errors", noremap = true, silent = true })
