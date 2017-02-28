" highlight object - managing highlights on a buffer

let s:save_cpo = &cpo
set cpo&vim

function! colorscheme#kemonofriends#highlight#new(positions, colors) abort  "{{{
  " NOTE: The 'positions' is the list of positions, like [[1, 1], [1, 2], ...].
  " NOTE: The 'colors' is the list of color sequence, like ['Visual', 'NONE', 'END'].
  "       'NONE' does nothing. 'END' quench highlight and terminates the sequence.
  let highlight = deepcopy(s:highlight)
  for pos in deepcopy(a:positions)
    if highlight.positions == [] || len(highlight.positions[-1]) == 7
      call add(highlight.positions, [])
    endif
    call add(highlight.positions[-1], pos)
  endfor
  let highlight.colors = deepcopy(a:colors)
  return highlight
endfunction
"}}}

" s:highlight "{{{
let s:highlight = {
      \   'on': 0,
      \   'winid': 0,
      \   'bufnr': 0,
      \   'hi_group': '',
      \   'hi_ids': [],
      \   'positions': [],
      \   'colors': [],
      \ }
"}}}
function! s:highlight.initialize() dict abort "{{{
  call self.quench()
  let self.on = 0
  let self.winid = 0
  let self.bufnr = 0
  let self.hi_group = ''
  let self.hi_ids = []
  let self.positions = []
  let self.colors = []
endfunction
"}}}
function! s:highlight.start() dict abort "{{{
  if self.colors != []
    let hi_group = remove(self.colors, 0)
    if hi_group ==# 'NONE'
      return
    endif

    if hi_group ==# 'END'
      call self.quench()
    else
      call self.show(hi_group)
    endif
  endif
  return self
endfunction
"}}}
function! s:highlight.next() dict abort "{{{
  if self.colors == []
    return
  endif

  let hi_group = remove(self.colors, 0)
  if hi_group ==# 'NONE'
    return
  endif

  if hi_group ==# 'END'
    call self.quench()
  else
    if self.on
      call self.change(hi_group)
    else
      call self.show(hi_group)
    endif
  endif
endfunction
"}}}
function! s:highlight.change(hi_group) dict abort "{{{
  let [tabnr, winnr, view] = [tabpagenr(), winnr(), winsaveview()]
  call self.quench()
  let succeeded = 1
  if self.is_in_highlighted_window()
    let succeeded = self.show(a:hi_group)
  else
    if self.goto_highlighted_window()
      let succeeded = self.show(a:hi_group)
    else
      let succeeded = 0
    endif
    call s:goto_window(winnr, tabnr, view)
  endif
  return succeeded
endfunction
"}}}
function! s:highlight.show(...) dict abort "{{{
  if self.positions == []
    return 0
  endif

  if a:0 < 1
    if self.hi_group ==# ''
      return 0
    else
      let hi_group = self.hi_group
    endif
  else
    let hi_group = a:1
  endif

  if self.on
    call self.quench()
  endif

  let endline = line('$')
  let filter = '1 <= v:val[0] && v:val[0] <= endline
           \ && 1 <= v:val[1] && v:val[1] <= col([v:val[0], '$'])'
  for pos_list in self.positions
    let filtered = filter(copy(pos_list), filter)
    call add(self.hi_ids, matchaddpos(hi_group, filtered))
  endfor
  call filter(self.hi_ids, 'v:val > 0')
  let self.on = 1
  let self.hi_group = hi_group
  let self.winid = win_getid()
  let self.bufnr = bufnr('%')
  return 1
endfunction
"}}}
function! s:highlight.quench() dict abort "{{{
  if !self.on
    return 0
  endif

  let [tabnr, winnr, view] = [tabpagenr(), winnr(), winsaveview()]
  if self.is_in_highlighted_window()
    call map(self.hi_ids, 'matchdelete(v:val)')
    call filter(self.hi_ids, 'v:val > 0')
    let succeeded = 1
  else
    if self.goto_highlighted_window()
      call map(self.hi_ids, 'matchdelete(v:val)')
      call filter(self.hi_ids, 'v:val > 0')
    else
      call filter(self.hi_ids, 0)
    endif
    let succeeded = 1
    call s:goto_window(winnr, tabnr, view)
  endif

  if succeeded
    let self.on = 0
  endif
  return succeeded
endfunction
"}}}
function! s:highlight.is_in_highlighted_window() dict abort "{{{
  return self.winid == win_getid()
endfunction
"}}}
function! s:highlight.goto_highlighted_window() dict abort "{{{
  return win_gotoid(self.winid)
endfunction
"}}}

" private functions
function! s:goto_window(winnr, ...) abort "{{{
  if a:0 > 0
    if !s:goto_tab(a:1)
      return 0
    endif
  endif


  try
    if a:winnr != winnr()
      execute printf('noautocmd %swincmd w', a:winnr)
    endif
  catch /^Vim\%((\a\+)\)\=:E16/
    return 0
  endtry

  if a:0 > 1
    call winrestview(a:2)
  endif

  return 1
endfunction
"}}}
function! s:goto_tab(tabnr) abort  "{{{
  if a:tabnr != tabpagenr()
    execute 'noautocmd tabnext ' . a:tabnr
  endif
  return tabpagenr() == a:tabnr ? 1 : 0
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
