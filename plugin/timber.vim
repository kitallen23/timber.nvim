if exists('g:loaded_timber') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command to run our plugin
command! Timber lua require'timber'.log()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_timber = 1
