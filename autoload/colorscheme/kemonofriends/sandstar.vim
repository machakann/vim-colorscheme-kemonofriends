let s:save_cpo = &cpo
set cpo&vim

" global options "{{{
function! s:get(name, default) abort
  return get(g:, 'colorscheme_kemonofriends_sandstar_' . a:name, a:default)
endfunction
let g:colorscheme_kemonofriends_sandstar_active   = s:get('active',   1)
let g:colorscheme_kemonofriends_sandstar_interval = s:get('interval', 50)
let g:colorscheme_kemonofriends_sandstar_duration = s:get('duration', 200)
"}}}
" script local variables "{{{
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
    call colorscheme#kemonofriends#sandstar#vanish()
    augroup colorscheme-kemonofriends-event-CursorMoved
      autocmd!
    augroup END
  endif

  if g:colors_name ==# 'kemonofriends' && exists('g:lightline#colorscheme#kemonofriends#palette')
    call lightline#colorscheme#kemonofriends#refresh()
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

  let radius = s:get_radius()
  call colorscheme#kemonofriends#sandstar#emerge(getpos('.')[1:2], radius)
  let s:tic = 0
endfunction
"}}}
function! colorscheme#kemonofriends#sandstar#emerge(pos, radius, ...) abort "{{{
  let duration = a:0 > 0 ? a:1 : g:colorscheme_kemonofriends_sandstar_duration
  if duration > 0
    let color_series = a:0 > 1 ? a:2 : s:color.get_series()
    let positions = s:list_square_pos(a:pos, a:radius)
    let r_array = range(len(positions))
    let circles = []
    for i in range(len(positions))
      let r = r_array[i]
      let rgroup = positions[i]
      if rgroup == []
        continue
      endif
      let color_sequence = repeat(['NONE'], r) + repeat(color_series + reverse(copy(color_series))[1:], 2) + ['QUENCH']
      let highlight = colorscheme#kemonofriends#highlight#new(rgroup, color_sequence)
      call highlight.start()
      call add(circles, highlight)
    endfor
    let id = s:timer_start(circles, duration, 'next', -1)
    call s:set_autocmds(id)
  endif
endfunction
"}}}
function! colorscheme#kemonofriends#sandstar#vanish(...) abort "{{{
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

function! s:get_radius() abort "{{{
  let n = localtime()
  let n = n - n/10*10
  if n <= 1
    let radius = 0
  elseif n <= 4
    let radius = 1
  elseif n <= 7
    let radius = 2
  else
    let radius = 3
  endif
  return radius
endfunction
"}}}
function! s:list_square_pos(center, radius) abort "{{{
  let positions = []
  if a:center[0] >= 1
    call add(positions, [copy(a:center)])
  else
    call add(positions, [])
  endif
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
      call filter(temp, 'v:val[0] >= 1')
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
  endtry

  call filter(circles, 'v:val.colors != [] && v:val.positions != []')
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
    call add(s:obsolete_augroup, a:id)
    call timer_start(1000, s:SID . 'terminate_augroup')
  endtry
endfunction
"}}}
function! s:terminate_augroup(dummy) abort  "{{{
  for id in s:obsolete_augroup
    call s:terminate_autocmds(id)
    execute 'augroup! colorscheme-kemonofriends-sandstar-' . id
  endfor
  call filter(s:obsolete_augroup, 0)
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
  execute 'augroup colorscheme-kemonofriends-sandstar-' . a:id
    autocmd!
    execute printf('autocmd CmdWinEnter <buffer> call s:pause_in_cmdline_window(%s)', a:id)
    execute printf('autocmd WinLeave <buffer> call s:terminate_highlight(%s, "WinLeave")', a:id)
    execute printf('autocmd BufUnload <buffer> call s:terminate_highlight(%s, "BufUnload")', a:id)
    execute printf('autocmd BufEnter * call s:toggle_highlight(%s)', a:id)
  augroup END
endfunction
"}}}
function! s:terminate_autocmds(id) abort "{{{
  execute 'augroup colorscheme-kemonofriends-sandstar-' . a:id
    autocmd!
  augroup END
endfunction
"}}}
function! s:terminate_highlight(id, event) abort  "{{{
  if get(s:timer_table, a:id, []) == []
    return
  endif
  call s:terminate(a:id)
endfunction
"}}}
function! s:toggle_highlight(id) abort "{{{
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
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" vim:set ts=2 sts=2 sw=2:
