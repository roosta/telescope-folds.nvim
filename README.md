🔎 telescope-folds.nvim
=========================

Neovim plugin that lets you fuzzy search for folds in a file using Telescope.

## Requirements

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) is required for this plugin to work.

## Installation

Use your favorite plugin manager, for example with [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'roosta/telescope-folds.nvim',
  requires = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('telescope').load_extension('folds')
  end
}
```

Or with [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'roosta/telescope-folds.nvim',
  dependencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('telescope').load_extension('folds')
  end
}
```

## Usage instructions

telescope-folds introduces a command `:Folds` and a Telescope extension.

### Command

`:Folds`

Open a Telescope picker and search for folds in the current file. On selection, telescope-folds will move
you to that fold's line number and open just enough folds to show the fold you
selected (`zv`).

### Lua API

```lua
require('telescope').extensions.folds.folds()
```

### Keymapping

It can be useful to bind this command to something:

```lua
-- Vim script
vim.cmd([[nnoremap <leader>jf :Folds<CR>]])

-- Lua
vim.keymap.set('n', '<leader>jf', ':Folds<CR>', { noremap = true, silent = true })
-- or
vim.keymap.set('n', '<leader>jf', function()
  require('telescope').extensions.folds.folds()
end, { noremap = true, silent = true })
```


## Related projects

- [gbirke/telescope-foldmarkers.nvim: Quickly jump to your fold markers {{{](https://github.com/gbirke/telescope-foldmarkers.nvim)
- [roosta/fzf-folds.vim: Vim plugin that lets you fuzzy search for folds in a file](https://github.com/roosta/fzf-folds.vim)

## Background

This is a lua port of `fzf-folds.vim` which was written in `vimscript` and using
[fzf.vim](https://github.com/junegunn/fzf.vim) as an interface. That plugin was
in turn inspired by
[foldlist](https://www.vim.org/scripts/script.php?script_id=500), which was
inspired by [taglist](https://www.vim.org/scripts/script.php?script_id=273).

## License

[MIT](https://github.com/roosta/telescope-folds.nvim/blob/main/LICENSE)
