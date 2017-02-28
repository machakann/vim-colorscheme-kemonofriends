let s:save_cpo = &cpo
set cpo&vim

function! s:hi_item(name) abort
  return [
        \   synIDattr(synIDtrans(hlID(a:name)), 'fg#', 'gui'),
        \   synIDattr(synIDtrans(hlID(a:name)), 'bg#', 'gui'),
        \   synIDattr(synIDtrans(hlID(a:name)), 'fg', 'cterm'),
        \   synIDattr(synIDtrans(hlID(a:name)), 'bg', 'cterm'),
        \ ]
endfunction

function! airline#themes#kemonofriends#build() abort
  let p = {}
  if &background ==# 'light'
    let p.normal   = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsKe1'), s:hi_item('ColorschemeKemonofriendsKe2'), s:hi_item('StatusLine'))
    let p.insert   = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsFu2'), s:hi_item('ColorschemeKemonofriendsFu1'), s:hi_item('StatusLine'))
    let p.inactive = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsRe1'), s:hi_item('ColorschemeKemonofriendsRe2'), s:hi_item('StatusLineNC'))
    let p.visual   = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsMo2'), s:hi_item('ColorschemeKemonofriendsMo1'), s:hi_item('StatusLineNC'))
    let p.replace  = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsNo2'), s:hi_item('ColorschemeKemonofriendsNo1'), s:hi_item('StatusLineNC'))
    let error = s:hi_item('ColorschemeKemonofriendsNn2')
    let warning = s:hi_item('ColorschemeKemonofriendsNn1')
  else
    let p.normal   = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsAo4'),     s:hi_item('ColorschemeKemonofriendsHaiiro4'), s:hi_item('StatusLine'))
    let p.insert   = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsAo4rev'),  s:hi_item('ColorschemeKemonofriendsHaiiro4'), s:hi_item('StatusLine'))
    let p.inactive = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsHaiiro5'), s:hi_item('ColorschemeKemonofriendsHaiiro4'), s:hi_item('StatusLineNC'))
    let p.visual   = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsAo4rev'),  s:hi_item('ColorschemeKemonofriendsHaiiro4'), s:hi_item('StatusLineNC'))
    let p.replace  = airline#themes#generate_color_map(s:hi_item('ColorschemeKemonofriendsAo4rev'),  s:hi_item('ColorschemeKemonofriendsHaiiro4'), s:hi_item('StatusLineNC'))
    let error = s:hi_item('ColorschemeKemonofriendsAka')
    let warning = s:hi_item('ColorschemeKemonofriendsKiiro')
  endif
  let p.normal.error     = error
  let p.insert.error     = error
  let p.inactive.error   = error
  let p.visual.error     = error
  let p.replace.error    = error
  let p.normal.warning   = warning
  let p.insert.warning   = warning
  let p.inactive.warning = warning
  let p.visual.warning   = warning
  let p.replace.warning  = warning
  return p
endfunction
function! g:airline#themes#kemonofriends#refresh() abort
  let g:airline#themes#kemonofriends#palette = airline#themes#kemonofriends#build()
endfunction
call g:airline#themes#kemonofriends#refresh()

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
