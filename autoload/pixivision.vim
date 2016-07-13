" pixivision - Make it interesting
" Version: 0.0.0
" Copyright (C) 2016 Kana Natsuno <http://whileimautomaton.net/>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Constants  "{{{1

let s:BUFNAME = '[pixivision]'

let s:FEED_URL = 'http://www.pixivision.net/ja/rss'
let s:XSLT_PATH = expand('<sfile>:p:h:h') . '/etc/feed-to-text.xslt'




let s:P_MESSASGE_LINE = 9

let s:P_LOADING = [
\   "             ,;+##+;,                        ",
\   "        `###############+                    ",
\   "      ;####################,                 ",
\   "    ,#######################+                ",
\   "   '########,       '#########`.,,,,,`       ",
\   "  ;######@            ;#####',,,,,,,,,,,`    ",
\   " ,#######              '##@:,,`````````,,,   ",
\   " +#####+          ,@;  `@#:,,``````     .,,  ",
\   " ######;         +@@@@` @#::``````       :,  ",
\   ".######;         @@@@@``@#,: ``````      :,  ",
\   ".######;         +@@@@`,##:,````````   ``:,  ",
\   "`#######          ,@; .@##;,, ````````` ,,.  ",
\   " #######@`           ;#####;,,. ``````.,,.   ",
\   " +########@.       +########+,,,,,,,,,,,     ",
\   " :#########################: ,,,..,.`        ",
\   "  #######################' ;;;;.             ",
\   "  .###################'   :;;;;,             ",
\   "   '############',       ,;;;;;              ",
\   "    +########;          `;;;;;               ",
\   "     '########         `;;;;;                ",
\   "      ,#######           .;;,                ",
\   "        ;####.                               ",
\ ]

let s:P_ERROR = [
\   "            `:'+##':`            ",
\   "        .##############+         ",
\   "      +###################.      ",
\   "    +#######################     ",
\   "   ########'`      .#########    ",
\   "  #######:           ,########   ",
\   " ;######`,:      ;##  ,#######`  ",
\   " ######+ :###;  ##;    #######;  ",
\   ".######.    :####      #######+  ",
\   "'######`    ,##,###'   #######:  ",
\   "#######:   ##'    .##..#######   ",
\   ";#######  +#         `#######;   ",
\   "`########           +########    ",
\   " ##########'`   `:#########'     ",
\   " :########################`      ",
\   "  ######################:        ",
\   "  `#################'.           ",
\   "   ;#########                    ",
\   "    '########.                   ",
\   "     ,#######'                   ",
\   "       ######`                   ",
\   "         :#'                     ",
\ ]







" Interface  "{{{1
function! pixivision#initialize_current_buffer_as_viewer()  "{{{2
  let bufid = bufnr(s:BUFNAME, !0)
  execute bufid 'buffer'

  setfiletype pixivision
  setlocal formatoptions+=m
  setlocal textwidth=70

  silent 0 put =s:P_LOADING
  let l = getline(s:P_MESSASGE_LINE)
  call setline(s:P_MESSASGE_LINE, l . 'Now loading...')
  redraw

  let s = systemlist(printf(
  \   'curl --silent %s | xsltproc %s -',
  \   s:FEED_URL,
  \   s:XSLT_PATH
  \ ))

  silent % delete _
  if v:shell_error == 0
    silent 0 put =s:format_feed(s)
    global/^description:/s///|normal! gqgq
    normal! G{}"_dG
    nnoremap <buffer> <Enter>  :<C-u>call <SID>open_article()<Enter>
  else
    silent 0 put =s:P_ERROR
    let l = getline(s:P_MESSASGE_LINE)
    call setline(s:P_MESSASGE_LINE, l . 'Error!')
  endif
  1

  return bufid
endfunction




function! pixivision#view()  "{{{2
  $ tabnew
  let bufid = bufnr(s:BUFNAME)
  if bufid == -1
    call pixivision#initialize_current_buffer_as_viewer()
  else
    execute bufid 'buffer'
  endif
endfunction








" Misc.  "{{{1
function! s:format_feed(lines)  "{{{2
  let bs = []

  for l in a:lines
    let e = s:parse_line(l)
    call extend(bs, [
    \   printf('［%s］%s', e['category'], e['title']),
    \   e['date'],
    \   e['link'],
    \   'description:' . e['description'],
    \   '',
    \ ])
  endfor

  return bs
endfunction




function! s:parse_line(line)  "{{{2
  let result = {}

  let items = split(a:line, '\t')
  for item in items
    let m = matchlist(item, '^\([^:]\+\):\(.*\)$')
    if !empty(m)
      let result[m[1]] = m[2]
    endif
  endfor

  return result
endfunction




function! s:open_article()  "{{{2
  normal! ma

  let lc = line('.')
  normal! {
  let lb = line('.')
  normal! }
  let le = line('.')
  let ls = search('^http://', 'bn')

  if lb <= lc && lc <= le && ls != 0
    silent call system('open ' . shellescape(getline(ls)))
  else
    echoerr 'P <Something wrong!  No URL found for this article!'
  endif

  normal! `a
endfunction








" __END__  "{{{1
" vim: foldmethod=marker
