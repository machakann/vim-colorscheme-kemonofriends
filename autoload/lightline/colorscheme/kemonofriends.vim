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

function! lightline#colorscheme#kemonofriends#build() abort
  let p = {'normal': {}, 'inactive': {}, 'insert': {}, 'visual': {}, 'replace': {}, 'tabline': {}}
  if &background ==# 'light'
    let p.normal.left     = [s:hi_item('ColorschemeKemonofriendsKe1'), s:hi_item('ColorschemeKemonofriendsKe2')]
    let p.normal.right    = [s:hi_item('ColorschemeKemonofriendsZu2'), s:hi_item('ColorschemeKemonofriendsZu1')]
    let p.normal.middle   = [s:hi_item('StatusLine')]
    let p.normal.error    = [s:hi_item('ColorschemeKemonofriendsNn2')]
    let p.normal.warning  = [s:hi_item('ColorschemeKemonofriendsNn1')]
    let p.inactive.left   = [s:hi_item('ColorschemeKemonofriendsRe1'), s:hi_item('ColorschemeKemonofriendsRe2')]
    let p.inactive.right  = [s:hi_item('ColorschemeKemonofriendsRe1'), s:hi_item('ColorschemeKemonofriendsRe2')]
    let p.inactive.middle = [s:hi_item('StatusLineNC')]
    let p.insert.left     = [s:hi_item('ColorschemeKemonofriendsFu2'), s:hi_item('ColorschemeKemonofriendsFu1')]
    let p.visual.left     = [s:hi_item('ColorschemeKemonofriendsMo2'), s:hi_item('ColorschemeKemonofriendsMo1')]
    let p.replace.left    = [s:hi_item('ColorschemeKemonofriendsNo2'), s:hi_item('ColorschemeKemonofriendsNo1')]
  else
    let p.normal.left     = [s:hi_item('ColorschemeKemonofriendsAo4'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
    let p.normal.right    = [s:hi_item('ColorschemeKemonofriendsAo4'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
    let p.normal.middle   = [s:hi_item('StatusLine')]
    let p.normal.error    = [s:hi_item('ColorschemeKemonofriendsAka')]
    let p.normal.warning  = [s:hi_item('ColorschemeKemonofriendsKiiro')]
    let p.inactive.left   = [s:hi_item('ColorschemeKemonofriendsHaiiro5'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
    let p.inactive.right  = [s:hi_item('ColorschemeKemonofriendsHaiiro5'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
    let p.inactive.middle = [s:hi_item('StatusLineNC')]
    let p.insert.left     = [s:hi_item('ColorschemeKemonofriendsAo4rev'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
    let p.visual.left     = [s:hi_item('ColorschemeKemonofriendsAo4rev'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
    let p.replace.left    = [s:hi_item('ColorschemeKemonofriendsAo4rev'), s:hi_item('ColorschemeKemonofriendsHaiiro4')]
  endif
  let p.tabline.left    = [s:hi_item('TabLineFill')]
  let p.tabline.right   = [s:hi_item('Todo')]
  let p.tabline.middle  = [s:hi_item('TabLineFill')]
  let p.tabline.tabsel  = [s:hi_item('TabLineSel')]
  return p
endfunction
function! g:lightline#colorscheme#kemonofriends#refresh() abort
  let g:lightline#colorscheme#kemonofriends#palette = lightline#colorscheme#kemonofriends#build()
  call lightline#colorscheme()
  let location = s:savewinview()
  windo call lightline#update_once()
  call s:restwinview(location)
endfunction
let g:lightline#colorscheme#kemonofriends#palette = lightline#colorscheme#kemonofriends#build()

function! s:savewinview() abort "{{{
  let location = {}
  let location.winid = win_getid()
  let location.view = winsaveview()
  return location
endfunction
"}}}
function! s:restwinview(location) abort "{{{
  if win_getid() != a:location.winid
    call win_gotoid(a:location.winid)
    call winrestview(a:location.view)
  endif
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
