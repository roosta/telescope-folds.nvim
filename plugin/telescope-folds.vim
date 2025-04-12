" telescope-folds.vim - Fuzzy search for folds using telescope
" Maintainer:   Daniel Berg <mail@roosta.sh>
" Version:      0.1

if exists('g:loaded_telescope_folds')
  finish
endif
let g:loaded_telescope_folds = 1

command! Folds lua require('telescope').extensions.folds.folds()
