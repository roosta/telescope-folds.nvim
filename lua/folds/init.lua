-- folds.lua - Fuzzy search for folds using telescope
-- Maintainer:   Daniel Berg <mail@roosta.sh>
-- Version:      0.1

local M = {}

local function warn(message)
  vim.api.nvim_echo({{message, "WarningMsg"}}, true, {})
  return false
end

-- Collect all folds in the current buffer
function M.collect_folds()
  local scanline = 1
  local prevline = -1
  local folds = {}
  local view = vim.fn.winsaveview()

  vim.api.nvim_win_set_cursor(0, {1, 0})

  -- Locate every fold, store information that lets us close and move to a fold
  while scanline ~= prevline do
    if vim.fn.foldlevel(scanline) > 0 then
      local closed = vim.fn.foldclosed(scanline)
      if closed == -1 then
        vim.cmd("normal! zc")
      end
      local foldtext = vim.fn.foldtextresult(scanline)
      table.insert(folds, {scanline, closed, foldtext})
      vim.cmd("normal! zo")
    end
    vim.cmd("keepjumps normal! zj")
    prevline = scanline
    scanline = vim.fn.line(".")
  end

  if #folds == 0 then
    -- Move cursor back where we started
    vim.fn.winrestview(view)
    error("No folds found")
  end

  -- Move through and close all the folds we opened
  for i = #folds, 1, -1 do
    local fl = folds[i]
    local line, closed = fl[1], fl[2]
    if closed >= 0 then
      vim.api.nvim_win_set_cursor(0, {line, 0})
      vim.cmd("normal! zc")
    end
  end

  vim.fn.winrestview(view)

  -- Format the folds for display
  local formatted_folds = {}
  for _, fold in ipairs(folds) do
    table.insert(formatted_folds, {
      line = fold[1],
      text = fold[3],
      display = fold[3],
    })
  end

  return formatted_folds
end

-- Jump to the selected fold
function M.jump_to_fold(fold)
  vim.cmd("normal! m'")
  vim.api.nvim_win_set_cursor(0, {fold.line, 0})
  vim.cmd("normal! zvzz")
end

-- Run the fold finder
function M.find_folds()
  local ok, folds = pcall(M.collect_folds)
  if not ok then
    return warn(folds)
  end

  return folds
end

return M

