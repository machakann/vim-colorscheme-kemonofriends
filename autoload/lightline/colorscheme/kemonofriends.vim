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
    let p.normal.left     = [s:hi_item('ColorschemeKemonofriendsLightlineKe1'), s:hi_item('ColorschemeKemonofriendsLightlineKe2')]
    let p.normal.right    = [s:hi_item('ColorschemeKemonofriendsLightlineZu2'), s:hi_item('ColorschemeKemonofriendsLightlineZu1')]
    let p.normal.middle   = [s:hi_item('StatusLine')]
    let p.normal.error    = [s:hi_item('ColorschemeKemonofriendsLightlineNn2')]
    let p.normal.warning  = [s:hi_item('ColorschemeKemonofriendsLightlineNn1')]
    let p.inactive.left   = [s:hi_item('ColorschemeKemonofriendsLightlineRe1'), s:hi_item('ColorschemeKemonofriendsLightlineRe2')]
    let p.inactive.right  = [s:hi_item('ColorschemeKemonofriendsLightlineRe1'), s:hi_item('ColorschemeKemonofriendsLightlineRe2')]
    let p.inactive.middle = [s:hi_item('StatusLineNC')]
    let p.insert.left     = [s:hi_item('ColorschemeKemonofriendsLightlineFu2'), s:hi_item('ColorschemeKemonofriendsLightlineFu1')]
    let p.visual.left     = [s:hi_item('ColorschemeKemonofriendsLightlineMo2'), s:hi_item('ColorschemeKemonofriendsLightlineMo1')]
    let p.replace.left    = [s:hi_item('ColorschemeKemonofriendsLightlineNo2'), s:hi_item('ColorschemeKemonofriendsLightlineNo1')]
  else
    let p.normal.left     = [s:hi_item('ColorschemeKemonofriendsLightlineAo4'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
    let p.normal.right    = [s:hi_item('ColorschemeKemonofriendsLightlineAo4'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
    let p.normal.middle   = [s:hi_item('StatusLine')]
    let p.normal.error    = [s:hi_item('ColorschemeKemonofriendsLightlineAka')]
    let p.normal.warning  = [s:hi_item('ColorschemeKemonofriendsLightlineKiiro')]
    let p.inactive.left   = [s:hi_item('ColorschemeKemonofriendsLightlineHaiiro5'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
    let p.inactive.right  = [s:hi_item('ColorschemeKemonofriendsLightlineHaiiro5'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
    let p.inactive.middle = [s:hi_item('StatusLineNC')]
    let p.insert.left     = [s:hi_item('ColorschemeKemonofriendsLightlineAo4rev'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
    let p.visual.left     = [s:hi_item('ColorschemeKemonofriendsLightlineAo4rev'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
    let p.replace.left    = [s:hi_item('ColorschemeKemonofriendsLightlineAo4rev'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  endif
  let p.tabline.left    = [s:hi_item('TabLineFill')]
  let p.tabline.right   = [s:hi_item('Todo')]
  let p.tabline.middle  = [s:hi_item('TabLineFill')]
  let p.tabline.tabsel  = [s:hi_item('TabLineSel')]
  return p
endfunction
let g:lightline#colorscheme#kemonofriends#palette = lightline#colorscheme#kemonofriends#build()

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
