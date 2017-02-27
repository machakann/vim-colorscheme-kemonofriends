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

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'visual': {}, 'replace': {}, 'tabline': {}}
if &background ==# 'light'
  let s:p.normal.left     = [s:hi_item('ColorschemeKemonofriendsLightlineKe1'), s:hi_item('ColorschemeKemonofriendsLightlineKe2')]
  let s:p.normal.right    = [s:hi_item('ColorschemeKemonofriendsLightlineZu2'), s:hi_item('ColorschemeKemonofriendsLightlineZu1')]
  let s:p.normal.middle   = [s:hi_item('StatusLine')]
  let s:p.normal.error    = [s:hi_item('ColorschemeKemonofriendsLightlineNn2')]
  let s:p.normal.warning  = [s:hi_item('ColorschemeKemonofriendsLightlineNn1')]
  let s:p.inactive.left   = [s:hi_item('ColorschemeKemonofriendsLightlineRe1'), s:hi_item('ColorschemeKemonofriendsLightlineRe2')]
  let s:p.inactive.right  = [s:hi_item('ColorschemeKemonofriendsLightlineRe1'), s:hi_item('ColorschemeKemonofriendsLightlineRe2')]
  let s:p.inactive.middle = [s:hi_item('StatusLineNC')]
  let s:p.insert.left     = [s:hi_item('ColorschemeKemonofriendsLightlineFu2'), s:hi_item('ColorschemeKemonofriendsLightlineFu1')]
  let s:p.visual.left     = [s:hi_item('ColorschemeKemonofriendsLightlineMo2'), s:hi_item('ColorschemeKemonofriendsLightlineMo1')]
  let s:p.replace.left    = [s:hi_item('ColorschemeKemonofriendsLightlineNo2'), s:hi_item('ColorschemeKemonofriendsLightlineNo1')]
else
  let s:p.normal.left     = [s:hi_item('ColorschemeKemonofriendsLightlineAo4'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  let s:p.normal.right    = [s:hi_item('ColorschemeKemonofriendsLightlineAo4'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  let s:p.normal.middle   = [s:hi_item('StatusLine')]
  let s:p.normal.error    = [s:hi_item('ColorschemeKemonofriendsLightlineAka')]
  let s:p.normal.warning  = [s:hi_item('ColorschemeKemonofriendsLightlineKiiro')]
  let s:p.inactive.left   = [s:hi_item('ColorschemeKemonofriendsLightlineHaiiro5'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  let s:p.inactive.right  = [s:hi_item('ColorschemeKemonofriendsLightlineHaiiro5'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  let s:p.inactive.middle = [s:hi_item('StatusLineNC')]
  let s:p.insert.left     = [s:hi_item('ColorschemeKemonofriendsLightlineAo4rev'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  let s:p.visual.left     = [s:hi_item('ColorschemeKemonofriendsLightlineAo4rev'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
  let s:p.replace.left    = [s:hi_item('ColorschemeKemonofriendsLightlineAo4rev'), s:hi_item('ColorschemeKemonofriendsLightlineHaiiro4')]
endif
let s:p.tabline.left    = [s:hi_item('TabLineFill')]
let s:p.tabline.right   = [s:hi_item('Todo')]
let s:p.tabline.middle  = [s:hi_item('TabLineFill')]
let s:p.tabline.tabsel  = [s:hi_item('TabLineSel')]
let g:lightline#colorscheme#kemonofriends#palette = s:p

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
