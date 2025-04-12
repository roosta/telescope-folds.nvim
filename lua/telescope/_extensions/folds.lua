-- telescope-folds.lua - Telescope extension for fuzzy searching folds
-- Maintainer:   Daniel Berg <mail@roosta.sh>
-- Version:      0.1

local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error("This plugin requires telescope.nvim (https://github.com/nvim-telescope/telescope.nvim)")
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local folds = require("folds")

local folds_picker = function(opts)
  opts = opts or {}

  local results = folds.find_folds()
  if not results then
    return
  end

  pickers.new(opts, {
    prompt_title = "Folds",
    finder = finders.new_table({
      results = results,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.text,
          ordinal = entry.text,
          lnum = entry.line,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        folds.jump_to_fold(selection.value)
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension({
  exports = {
    folds = folds_picker,
  },
})
