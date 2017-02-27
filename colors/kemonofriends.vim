scriptencoding utf-8
"------------------------------------------------------------
" Name: kemonofriends.vim
" Description: ようこそジャパリパークへ！
" Maintainer: machakann
"------------------------------------------------------------

let s:save_cpo = &cpo
set cpo&vim

highlight clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'kemonofriends'

function! s:set() abort
  let none       = {'gui': 'NONE',      'cterm': 'NONE'}
  let bold       = {'gui': 'bold',      'cterm': 'bold'}
  let underline  = {'gui': 'underline', 'cterm': 'underline'}
  let undercurl  = {'gui': 'undercurl', 'cterm': 'underline'}

  let highlight_group = {}
  if &background ==# 'light'
    let shiro    = {'gui': '#ffffff', 'cterm': '15'}
    let kiiro    = {'gui': '#ffd25d', 'cterm': '220'}
    let usuki    = {'gui': '#fcdc85', 'cterm': '221'}
    let usuusuki = {'gui': '#fef993', 'cterm': '229'}
    let yamabuki = {'gui': '#f5af3d', 'cterm': '214'}
    let midori   = {'gui': '#14ae66', 'cterm': '29'}
    let kimidori = {'gui': '#8cc520', 'cterm': '106'}
    let uguisu   = {'gui': '#c3d900', 'cterm': '148'}
    let daidai   = {'gui': '#e95320', 'cterm': '106'}
    let aomidori = {'gui': '#00b093', 'cterm': '36'}
    let pink     = {'gui': '#ed007c', 'cterm': '162'}
    let mizuiro  = {'gui': '#00a3e0', 'cterm': '33'}
    let ao       = {'gui': '#2278c5', 'cterm': '25'}
    let usuao    = {'gui': '#dcf06c', 'cterm': '184'}
    let haiiro   = {'gui': '#868678', 'cterm': '245'}
    let usuhai   = {'gui': '#eeeee0', 'cterm': '255'}
    let aka      = {'gui': '#e70012', 'cterm': '1'}
    let usuaka   = {'gui': '#fcba85', 'cterm': '216'}
    let murasaki = {'gui': '#ab2b8c', 'cterm': '91'}
    let kogecha  = {'gui': '#3f2116', 'cterm': '52'}
    let kuro     = {'gui': '#3f2116', 'cterm': '233'}
    let ss_p1    = {'gui': '#fcbafc', 'cterm': '224'}
    let ss_p2    = {'gui': '#ff9efb', 'cterm': '225'}
    let ss_p3    = {'gui': '#ed67ce', 'cterm': '219'}
    let ss_p4    = {'gui': '#a655b1', 'cterm': '213'}
    let ss_g1    = {'gui': '#e9f8e2', 'cterm': '229'}
    let ss_g2    = {'gui': '#c6fcb5', 'cterm': '193'}
    let ss_g3    = {'gui': '#97fba4', 'cterm': '191'}
    let ss_g4    = {'gui': '#60d154', 'cterm': '149'}
    let ss_y1    = {'gui': '#faf4e1', 'cterm': '229'}
    let ss_y2    = {'gui': '#fbff90', 'cterm': '228'}
    let ss_y3    = {'gui': '#fdff7d', 'cterm': '227'}
    let ss_y4    = {'gui': '#cfcb5b', 'cterm': '186'}

    "*** highlight groups (:h highlight-groups) ***"
    let highlight_group.Normal       = [kuro,     usuki,    none,      none]
    let highlight_group.Visual       = [none,     usuhai,   none,      none]
    let highlight_group.VisualNOS    = [none,     usuhai,   none,      none]
    let highlight_group.Cursor       = [pink,     shiro,    none,      none]
    let highlight_group.CursorIM     = [shiro,    daidai,   none,      none]
    let highlight_group.CursorLine   = [none,     kiiro,    none,      none]
    let highlight_group.CursorColumn = highlight_group.CursorLine
    let highlight_group.StatusLine   = [usuusuki, kogecha,  none,      none]
    let highlight_group.StatusLineNC = [shiro,    kogecha,  none,      none]
    let highlight_group.WildMenu     = [kogecha,  usuusuki, none,      none]
    let highlight_group.LineNr       = [kogecha,  kiiro,    none,      none]
    let highlight_group.CursorLineNr = [pink,     kiiro,    bold,      none]
    let highlight_group.FoldColumn   = [shiro,    yamabuki, none,      none]
    let highlight_group.SignColumn   = [aomidori, yamabuki, none,      none]
    let highlight_group.VertSplit    = highlight_group.StatusLineNC
    let highlight_group.ColorColumn  = [none,     yamabuki, none,      none]
    let highlight_group.Folded       = [shiro,    yamabuki, none,      none]
    let highlight_group.TabLineSel   = [kogecha,  usuki,    none,      none]
    let highlight_group.TabLine      = highlight_group.StatusLine
    let highlight_group.TabLineFill  = highlight_group.StatusLine
    let highlight_group.Search       = [shiro,    aomidori, none,      none]
    let highlight_group.IncSearch    = [none,     usuaka,   none,      none]
    let highlight_group.ErrorMsg     = [aka,      none,     none,      none]
    let highlight_group.ModeMsg      = [aomidori, none,     bold,      none]
    let highlight_group.MoreMsg      = [aomidori, none,     bold,      none]
    let highlight_group.Question     = [aomidori, none,     bold,      none]
    let highlight_group.Title        = [midori,   none,     none,      none]
    let highlight_group.WarningMsg   = [kimidori, none,     none,      none]
    let highlight_group.Pmenu        = [shiro,    yamabuki, none,      none]
    let highlight_group.PmenuSel     = [kuro,     kiiro,    none,      none]
    let highlight_group.PmenuSbar    = [usuusuki, kogecha,  none,      none]
    let highlight_group.PmenuThumb   = [kogecha,  usuusuki, none,      none]
    let highlight_group.DiffAdd      = [none,     usuao,    none,      none]
    let highlight_group.DiffChange   = [none,     kiiro,    none,      none]
    let highlight_group.DiffDelete   = [none,     usuaka,   none,      none]
    let highlight_group.DiffText     = [none,     kiiro,    underline, none]
    let highlight_group.Directory    = [midori,   none,     none,      none]
    let highlight_group.NonText      = [usuusuki, none,     none,      none]
    let highlight_group.SpecialKey   = [kimidori, none,     none,      none]
    let highlight_group.Conceal      = [kimidori, none,     none,      none]

    "*** Syntax groups (:h group-name) ***"
    let highlight_group.Comment      = [haiiro,   none,     none,      none]
    let highlight_group.Constant     = [pink,     none,     none,      none]
    let highlight_group.Identifier   = [aka,      none,     none,      none]
    let highlight_group.Statement    = [midori,   none,     none,      none]
    let highlight_group.PreProc      = [mizuiro,  none,     none,      none]
    let highlight_group.Type         = [ao,       none,     none,      none]
    let highlight_group.Special      = [murasaki, none,     none,      none]
    let highlight_group.Underlined   = [daidai,   none,     underline, none]
    let highlight_group.Ignore       = [haiiro,   none,     none,      none]
    let highlight_group.Error        = [aka,      none,     undercurl, aka]
    let highlight_group.Todo         = [pink,     shiro,    bold,      none]

    "*** Settings for plugins ***"
    let highlight_group.MatchParen = [shiro, kimidori, none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineKe1 = [shiro, midori,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineKe2 = [shiro, kimidori, none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineMo1 = [kuro,  kiiro,    none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineMo2 = [shiro, daidai,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineNo1 = [shiro, aomidori, none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineNo2 = [shiro, pink,     none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineFu1 = [shiro, mizuiro,  none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineFu2 = [shiro, ao,       none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineRe1 = [shiro, haiiro,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineRe2 = [kuro,  usuhai,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineNn1 = [shiro, kiiro,    none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineNn2 = [shiro, aka,      none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineZu1 = [shiro, uguisu,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineZu2 = [shiro, murasaki, none, none]

    "*** Settings for sandstars ***"
    let highlight_group.ColorschemeKemonofriendsSandstarPink1   = [none, ss_p1, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarPink2   = [none, ss_p2, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarPink3   = [none, ss_p3, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarPink4   = [none, ss_p4, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarGreen1  = [none, ss_g1, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarGreen2  = [none, ss_g2, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarGreen3  = [none, ss_g3, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarGreen4  = [none, ss_g4, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarYellow1 = [none, ss_y1, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarYellow2 = [none, ss_y2, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarYellow3 = [none, ss_y3, none, none]
    let highlight_group.ColorschemeKemonofriendsSandstarYellow4 = [none, ss_y4, none, none]
    augroup colorscheme-kemonofriends-event-ColorScheme
      autocmd!
      autocmd ColorScheme * call colorscheme#kemonofriends#sandstar#eventColorScheme()
    augroup END
    augroup colorscheme-kemonofriends-event-CursorMoved
      autocmd!
      if get(g:, 'colorscheme_kemonofriends_sandstar_active', 1)
        autocmd CursorMoved * call colorscheme#kemonofriends#sandstar#tic()
      endif
    augroup END

    let bg_none    = {'gui': kiiro.gui, 'cterm': 'NONE'}
  else
    let shiro   = {'gui': '#ffffff', 'cterm': '15'}
    let haiiro1 = {'gui': '#f1f1f1', 'cterm': '255'}
    let haiiro2 = {'gui': '#d1d0d1', 'cterm': '251'}
    let haiiro3 = {'gui': '#bfbfbf', 'cterm': '249'}
    let haiiro4 = {'gui': '#9c9c9c', 'cterm': '245'}
    let haiiro5 = {'gui': '#6b6b6b', 'cterm': '240'}
    let haiiro6 = {'gui': '#4b4b4b', 'cterm': '237'}
    let haiiro7 = {'gui': '#252525', 'cterm': '234'}
    let kuro    = {'gui': '#000000', 'cterm': '0'}
    let ao1     = {'gui': '#defdfe', 'cterm': '195'}
    let ao2     = {'gui': '#b7bdff', 'cterm': '147'}
    let ao3     = {'gui': '#4a5ded', 'cterm': '12'}
    let ao4     = {'gui': '#3e48b2', 'cterm': '19'}
    let aka1    = {'gui': '#f9dfde', 'cterm': '224'}
    let aka2    = {'gui': '#e70012', 'cterm': '1'}
    let kiiro1  = {'gui': '#fffbbc', 'cterm': '229'}
    let kiiro2  = {'gui': '#ffd25d', 'cterm': '220'}

    "*** highlight groups (:h highlight-groups) ***"
    let highlight_group.Normal       = [shiro,   haiiro2, none,      none]
    let highlight_group.Visual       = [none,    ao2,     none,      none]
    let highlight_group.VisualNOS    = [none,    ao2,     none,      none]
    let highlight_group.Cursor       = [ao3,     shiro,   none,      none]
    let highlight_group.CursorIM     = [shiro,   ao3,     none,      none]
    let highlight_group.CursorLine   = [none,    haiiro3, none,      none]
    let highlight_group.CursorColumn = highlight_group.CursorLine
    let highlight_group.StatusLine   = [shiro,   haiiro7, none,      none]
    let highlight_group.StatusLineNC = [haiiro3, haiiro7, none,      none]
    let highlight_group.WildMenu     = [haiiro7, haiiro1, none,      none]
    let highlight_group.LineNr       = [kuro,    haiiro1, none,      none]
    let highlight_group.CursorLineNr = [ao3,     haiiro1, bold,      none]
    let highlight_group.FoldColumn   = [kuro,    haiiro1, none,      none]
    let highlight_group.SignColumn   = [ao3,     haiiro1, none,      none]
    let highlight_group.VertSplit    = highlight_group.StatusLineNC
    let highlight_group.ColorColumn  = [none,    haiiro1, none,      none]
    let highlight_group.Folded       = [shiro,   haiiro4, none,      none]
    let highlight_group.TabLineSel   = [kuro,    haiiro2, none,      none]
    let highlight_group.TabLine      = highlight_group.StatusLine
    let highlight_group.TabLineFill  = highlight_group.StatusLine
    let highlight_group.Search       = [shiro,   ao2,     none,      none]
    let highlight_group.IncSearch    = [ao3,     haiiro1, none,      none]
    let highlight_group.ErrorMsg     = [aka2,     none,   none,      none]
    let highlight_group.ModeMsg      = [ao4,     none,    bold,      none]
    let highlight_group.MoreMsg      = [ao4,     none,    bold,      none]
    let highlight_group.Question     = [ao4,     none,    bold,      none]
    let highlight_group.Title        = [ao4,     none,    none,      none]
    let highlight_group.WarningMsg   = [kiiro2,   none,   none,      none]
    let highlight_group.Pmenu        = [shiro,   haiiro5, none,      none]
    let highlight_group.PmenuSel     = [shiro,   haiiro4, none,      none]
    let highlight_group.PmenuSbar    = [ao3,     haiiro1, none,      none]
    let highlight_group.PmenuThumb   = [haiiro1, ao3,     none,      none]
    let highlight_group.DiffAdd      = [ao2,     ao1,     none,      none]
    let highlight_group.DiffChange   = [kiiro2,  kiiro1,  none,      none]
    let highlight_group.DiffDelete   = [aka2,    aka1,    none,      none]
    let highlight_group.DiffText     = [kiiro2,  kiiro1,  underline, none]
    let highlight_group.Directory    = [ao3,     none,    none,      none]
    let highlight_group.NonText      = [haiiro1, none,    none,      none]
    let highlight_group.SpecialKey   = [ao4,     none,    none,      none]
    let highlight_group.Conceal      = [haiiro1, none,    none,      none]

    "*** Syntax groups (:h group-name) ***"
    let highlight_group.Comment      = [haiiro4, none,    none,      none]
    let highlight_group.Constant     = [haiiro6, none,    none,      none]
    let highlight_group.Identifier   = [haiiro5, none,    none,      none]
    let highlight_group.Statement    = [ao3,     none,    none,      none]
    let highlight_group.PreProc      = [ao4,     none,    none,      none]
    let highlight_group.Type         = [ao4,     none,    none,      none]
    let highlight_group.Special      = [ao4,     none,    none,      none]
    let highlight_group.Underlined   = [ao3,     none,    underline, none]
    let highlight_group.Ignore       = [haiiro4, none,    none,      none]
    let highlight_group.Error        = [aka2,    none,    undercurl, aka2]
    let highlight_group.Todo         = [ao4,     ao2,     none,      none]

    "*** Settings for plugins ***"
    let highlight_group.MatchParen   = [shiro,   ao2,     none,      none]
    let highlight_group.ColorschemeKemonofriendsLightlineHaiiro4 = [shiro,   haiiro4,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineHaiiro5 = [shiro,   haiiro5,   none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineAo4     = [shiro,   ao4,       none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineAo4rev  = [ao4,   shiro,       none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineAka     = [shiro,   aka2,      none, none]
    let highlight_group.ColorschemeKemonofriendsLightlineKiiro   = [kuro,    kiiro2,    none, none]

    let bg_none    = {'gui': haiiro2.gui, 'cterm': 'NONE'}
  endif

  if get(g:, 'colorscheme_no_background', 0)
    let highlight_group.Normal[1]      = bg_none
    let highlight_group.TabLineFill[1] = bg_none
    let highlight_group.VertSplit[1]   = bg_none
    let highlight_group.SignColumn[1]  = bg_none
  endif

  for [group, colors] in items(highlight_group)
    execute printf('highlight %s guifg=%s guibg=%s gui=%s, guisp=%s ctermfg=%s ctermbg=%s cterm=%s',
                \  group,
                \  colors[0]['gui'],
                \  colors[1]['gui'],
                \  colors[2]['gui'],
                \  colors[3]['gui'],
                \  colors[0]['cterm'],
                \  colors[1]['cterm'],
                \  colors[2]['cterm']
                \ )
  endfor
endfunction
call s:set()

let &cpo = s:save_cpo
unlet s:save_cpo
