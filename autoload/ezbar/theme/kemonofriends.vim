let s:save_cpo = &cpo
set cpo&vim

function! s:hi_item(name) abort
  return {
        \   'gui': [synIDattr(synIDtrans(hlID(a:name)), 'bg#', 'gui'), synIDattr(synIDtrans(hlID(a:name)), 'fg#', 'gui')],
        \   'cterm': [synIDattr(synIDtrans(hlID(a:name)), 'bg', 'cterm'), synIDattr(synIDtrans(hlID(a:name)), 'fg', 'cterm')],
        \ }
endfunction
function! s:hi_revitem(name) abort
  return {
        \   'gui': [synIDattr(synIDtrans(hlID(a:name)), 'fg#', 'gui'), synIDattr(synIDtrans(hlID(a:name)), 'bg#', 'gui')],
        \   'cterm': [synIDattr(synIDtrans(hlID(a:name)), 'fg', 'cterm'), synIDattr(synIDtrans(hlID(a:name)), 'bg', 'cterm')],
        \ }
endfunction

function! ezbar#theme#kemonofriends#load() abort
  let StatusLine = s:hi_revitem('StatusLine')
  let StatusLineNC = s:hi_item('StatusLineNC')

  let theme = {'light': {}, 'dark': {}}
  if &background ==# 'light'
    let theme.light = {
          \ 'm_normal':    StatusLine,
          \ 'm_normal_1':  s:hi_item('ColorschemeKemonofriendsKe1'),
          \ 'm_normal_2':  s:hi_item('ColorschemeKemonofriendsKe2'),
          \ 'm_insert':    StatusLine,
          \ 'm_insert_1':  s:hi_item('ColorschemeKemonofriendsFu2'),
          \ 'm_insert_2':  s:hi_item('ColorschemeKemonofriendsFu1'),
          \ 'm_visual':    StatusLine,
          \ 'm_visual_1':  s:hi_item('ColorschemeKemonofriendsMo2'),
          \ 'm_visual_2':  s:hi_item('ColorschemeKemonofriendsMo1'),
          \ 'm_replace':   StatusLine,
          \ 'm_replace_1': s:hi_item('ColorschemeKemonofriendsNo2'),
          \ 'm_replace_2': s:hi_item('ColorschemeKemonofriendsNo1'),
          \ 'm_command':   StatusLine,
          \ 'm_command_1': s:hi_item('ColorschemeKemonofriendsZu1'),
          \ 'm_command_2': s:hi_item('ColorschemeKemonofriendsZu2'),
          \ 'm_select':    StatusLine,
          \ 'm_select_1':  s:hi_item('ColorschemeKemonofriendsNo1'),
          \ 'm_select_2':  s:hi_item('ColorschemeKemonofriendsNo2'),
          \ 'm_other':     StatusLine,
          \
          \ 'inactive':   StatusLineNC,
          \ 'inactive_1': s:hi_item('ColorschemeKemonofriendsRe1'),
          \ 'inactive_2': s:hi_item('ColorschemeKemonofriendsRe2'),
          \ 'warn':       s:hi_item('ColorschemeKemonofriendsNn2'),
          \ }
  else
    let theme.dark = {
          \ 'm_normal':    StatusLine,
          \ 'm_normal_1':  s:hi_item('ColorschemeKemonofriendsAo4'),
          \ 'm_normal_2':  s:hi_item('ColorschemeKemonofriendsHaiiro4'),
          \ 'm_insert':    StatusLine,
          \ 'm_insert_1':  s:hi_item('ColorschemeKemonofriendsAo4rev'),
          \ 'm_insert_2':  s:hi_item('ColorschemeKemonofriendsHaiiro4'),
          \ 'm_visual':    StatusLine,
          \ 'm_visual_1':  s:hi_item('ColorschemeKemonofriendsAo4rev'),
          \ 'm_visual_2':  s:hi_item('ColorschemeKemonofriendsHaiiro4'),
          \ 'm_replace':   StatusLine,
          \ 'm_replace_1': s:hi_item('ColorschemeKemonofriendsAo4rev'),
          \ 'm_replace_2': s:hi_item('ColorschemeKemonofriendsHaiiro4'),
          \ 'm_command':   StatusLine,
          \ 'm_command_1': s:hi_item('ColorschemeKemonofriendsAo4rev'),
          \ 'm_command_2': s:hi_item('ColorschemeKemonofriendsHaiiro4'),
          \ 'm_select':    StatusLine,
          \ 'm_select_1':  s:hi_item('ColorschemeKemonofriendsAo4rev'),
          \ 'm_select_2':  s:hi_item('ColorschemeKemonofriendsHaiiro4'),
          \ 'm_other':     s:hi_item('ColorschemeKemonofriendsAo4'),
          \
          \ 'inactive': s:hi_item('ColorschemeKemonofriendsHaiiro5'),
          \ 'warn':     s:hi_item('ColorschemeKemonofriendsAka'),
          \ }
  endif
  return theme
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
