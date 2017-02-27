let s:save_cpo = &cpo
set cpo&vim

" script local variables "{{{
" options
function! s:get(name, default) abort
  return get(g:, 'colorscheme_kemonofriends_sandstar_' . a:name, a:default)
endfunction
let g:colorscheme_kemonofriends_sandstar_active   = s:get('active',   1)
let g:colorscheme_kemonofriends_sandstar_interval = s:get('interval', 50)
let g:colorscheme_kemonofriends_sandstar_radius   = s:get('radius',   3)
let g:colorscheme_kemonofriends_sandstar_duration = s:get('duration', 200)

" intrinsic counter
let s:tic = 0

" color series
let s:color = {
      \   'tic': 0,
      \   'series': [
      \     ['ColorschemeKemonofriendsSandstarPink1', 'ColorschemeKemonofriendsSandstarPink2', 'ColorschemeKemonofriendsSandstarPink3', 'ColorschemeKemonofriendsSandstarPink4'],
      \     ['ColorschemeKemonofriendsSandstarGreen1', 'ColorschemeKemonofriendsSandstarGreen2', 'ColorschemeKemonofriendsSandstarGreen3', 'ColorschemeKemonofriendsSandstarGreen4'],
      \     ['ColorschemeKemonofriendsSandstarYellow1', 'ColorschemeKemonofriendsSandstarYellow2', 'ColorschemeKemonofriendsSandstarYellow3', 'ColorschemeKemonofriendsSandstarYellow4'],
      \   ],
      \ }
function! s:color.get_series() dict abort
  let color_series = self.series[self.tic]
  let self.tic = self.tic + 1 < len(self.series) ? self.tic + 1 : 0
  return color_series
endfunction

" types
let s:type_list = type([])

" features
let s:has_gui_running = has('gui_running')

" SID
function! s:SID() abort
  return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfunction
let s:SID = printf("\<SNR>%s_", s:SID())
delfunction s:SID
"}}}

function! colorscheme#kemonofriends#sandstar#eventColorScheme() abort "{{{
  let active = g:colorscheme_kemonofriends_sandstar_active
  if g:colors_name ==# 'kemonofriends' && &background ==# 'light' && active
    augroup colorscheme-kemonofriends-event-CursorMoved
      autocmd!
      autocmd CursorMoved * call colorscheme#kemonofriends#sandstar#tic()
    augroup END
  else
    call colorscheme#kemonofriends#sandstar#disappear()
    augroup colorscheme-kemonofriends-event-CursorMoved
      autocmd!
    augroup END
  endif

  if g:colors_name ==# 'kemonofriends' && exists('g:lightline#colorscheme#kemonofriends#palette')
    let g:lightline#colorscheme#kemonofriends#palette = lightline#colorscheme#kemonofriends#build()
    call lightline#colorscheme()
  endif
endfunction
"}}}
function! colorscheme#kemonofriends#sandstar#tic() abort "{{{
  let active = g:colorscheme_kemonofriends_sandstar_active
  if !active
    augroup colorscheme-kemonofriends-event-CursorMoved
      autocmd!
    augroup END
  endif

  let interval = g:colorscheme_kemonofriends_sandstar_interval
  let s:tic += 1
  if s:tic < interval
    return
  endif

  let radius = g:colorscheme_kemonofriends_sandstar_radius
  call colorscheme#kemonofriends#sandstar#emerge(getpos('.')[1:2], radius)
  let s:tic = 0
endfunction
"}}}
function! colorscheme#kemonofriends#sandstar#emerge(pos, radius, ...) abort "{{{
  let color_series = a:0 > 0 ? a:1 : s:color.get_series()
  let duration = a:0 > 1 ? a:2 : g:colorscheme_kemonofriends_sandstar_duration
  if duration > 0
    let positions = s:get_square_pos(a:pos, a:radius)
    let r_array = range(len(positions))
    let circles = []
    for i in range(len(positions))
      let r = r_array[i]
      let rgroup = positions[i]
      let color_sequence = repeat(['NONE'], r) + repeat(color_series + reverse(copy(color_series))[1:], 3) + ['END']
      let highlight = colorscheme#kemonofriends#highlight#new()
      call highlight.order(rgroup)
      call highlight.start(color_sequence)
      call add(circles, highlight)
    endfor
    let id = s:timer_start(circles, duration, 'next', -1)
    call s:set_autocmds(id)
  endif
endfunction
"}}}
function! colorscheme#kemonofriends#sandstar#disappear(...) abort "{{{
  if a:0 > 0
    let id_list = type(a:1) == s:type_list ? a:1 : a:000
  else
    let id_list = map(keys(s:timer_table), 'str2nr(v:val)')
  endif

  for id in id_list
    call s:terminate(id)
  endfor
endfunction
"}}}

function! s:get_square_pos(center, radius) abort "{{{
  let positions = s:list_square_pos(a:center, a:radius)
  let endline = line('$')
  let filter = '1 <= v:val[0] && v:val[0] <= endline
           \ && 1 <= v:val[1] && v:val[1] <= col([v:val[0], "$"])'
  for rgroup in positions
    call filter(rgroup, filter)
  endfor
  return positions
endfunction
"}}}
function! s:list_square_pos(center, radius) abort "{{{
  let positions = []
  call add(positions, [copy(a:center)])
  if a:radius > 0
    for r in range(1, a:radius)
      let temp = []
      let dx = range(r + 1)
      let dy = reverse(range(r + 1))
      for i in range(len(dx))
        call add(temp, [a:center[0] + dx[i], a:center[1] + dy[i]])
        call add(temp, [a:center[0] - dx[i], a:center[1] - dy[i]])
        if dx[i] != 0 && dy[i] != 0
          call add(temp, [a:center[0] + dx[i], a:center[1] - dy[i]])
          call add(temp, [a:center[0] - dx[i], a:center[1] + dy[i]])
        endif
      endfor
      call add(positions, temp)
    endfor
  endif
  return positions
endfunction
"}}}

" for time-dependent features "{{{
let s:timer_table = {}
let s:paused = []
let s:obsolete_augroup = []
function! s:timer_start(highlights, time, callback, ...) abort "{{{
  let n = get(a:000, 0, 1)
  let id = timer_start(a:time, s:SID . a:callback, {'repeat': n})
  let s:timer_table[id] = a:highlights
  return id
endfunction
"}}}
function! s:next(id) abort  "{{{
  if s:is_in_cmdline_window()
    call s:pause_in_cmdline_window(a:id)
    return
  endif

  let circles = s:timer_table[a:id]
  try
    for highlight in circles
      call highlight.next()
    endfor
  catch /^Vim\%((\a\+)\)\=:E523/
    " NOTE: For "textlock"
    call s:timer_start(s:timer_table[a:id], 50, 'terminate')
    return
  finally
    redraw
  endtry

  call filter(circles, 'v:val.colors != []')
  if circles == []
    call s:terminate(a:id)
  endif
endfunction
"}}}
function! s:hide(id) abort "{{{
  call s:pause(a:id)
  for highlight in s:timer_table[a:id]
    call highlight.quench()
  endfor
endfunction
"}}}
function! s:resume(...) abort "{{{
  if a:0 < 1
    let id_list = a:000
  else
    let id_list = s:paused
  endif
  for id in id_list
    call s:restart(id)
    for highlight in s:timer_table[id]
      call highlight.show()
    endfor
  endfor
endfunction
"}}}
function! s:pause(id) abort "{{{
  call timer_pause(a:id, 1)
  call add(s:paused, a:id)
endfunction
"}}}
function! s:restart(id) abort "{{{
  call timer_pause(a:id, 0)
  call filter(s:paused, 'v:val != a:id')
endfunction
"}}}
function! s:terminate(id) abort  "{{{
  call timer_stop(a:id)
  try
    for highlight in s:timer_table[a:id]
      call highlight.quench()
    endfor
  catch /^Vim\%((\a\+)\)\=:E523/
    " NOTE: For "textlock"
    call s:timer_start(s:timer_table[a:id], 50, 'terminate')
    return 1
  finally
    unlet s:timer_table[a:id]
    call s:metabolize_augroup(a:id)
    redraw
  endtry
endfunction
"}}}
function! s:metabolize_augroup(id) abort  "{{{
  " clean up autocommands in the current augroup
  execute 'augroup colorscheme-kemonofriends-highlight-' . a:id
    autocmd!
  augroup END

  " clean up obsolete augroup
  call filter(s:obsolete_augroup, 'v:val != a:id')
  for id in s:obsolete_augroup
    execute 'augroup! colorscheme-kemonofriends-highlight-' . id
  endfor
  call filter(s:obsolete_augroup, 0)

  " queue the current augroup
  call add(s:obsolete_augroup, a:id)
endfunction
"}}}
function! s:get_out_of_cmdwindow() abort "{{{
  augroup colorscheme-kemonofriends-pause
    autocmd!
    autocmd CursorMoved * call s:got_out_of_cmdwindow()
  augroup END
endfunction
"}}}
function! s:got_out_of_cmdwindow() abort "{{{
  call s:resume()
  augroup colorscheme-kemonofriends-pause
    autocmd!
  augroup END
endfunction
"}}}
function! s:is_in_cmdline_window() abort "{{{
  return getcmdwintype() !=# ''
endfunction
"}}}
function! s:set_autocmds(id) abort "{{{
  execute 'augroup colorscheme-kemonofriends-highlight-' . a:id
    autocmd!
    execute printf('autocmd CmdWinEnter <buffer> call s:pause_in_cmdline_window(%s)', a:id)
    execute printf('autocmd WinLeave <buffer> call s:cancel_highlight(%s, "WinLeave")', a:id)
    execute printf('autocmd BufUnload <buffer> call s:cancel_highlight(%s, "BufUnload")', a:id)
    execute printf('autocmd BufEnter * call s:switch_highlight(%s)', a:id)
  augroup END
endfunction
"}}}
function! s:cancel_autocmds(id) abort "{{{
  execute 'augroup colorscheme-kemonofriends-highlight-' . a:id
    autocmd!
  augroup END
endfunction
"}}}
function! s:cancel_highlight(id, event) abort  "{{{
  if get(s:timer_table, a:id, {}) == []
    return
  endif
  call s:terminate(a:id)
endfunction
"}}}
function! s:switch_highlight(id) abort "{{{
  let circles = get(s:timer_table, a:id, [])
  if circles == []
    return
  endif

  let highlight = get(circles, 0, {})
  if highlight == {} || !highlight.is_in_highlighted_window()
    return
  endif
  if highlight.bufnr == bufnr('%')
    call s:resume(a:id)
  else
    call s:hide(a:id)
  endif
endfunction
"}}}
function! s:pause_in_cmdline_window(id) abort "{{{
  call s:pause(a:id)
  augroup colorscheme-kemonofriends-pause
    autocmd!
    autocmd CmdWinLeave * call s:get_out_of_cmdwindow()
  augroup END
endfunction
"}}}
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
