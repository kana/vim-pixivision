if exists('b:current_syntax')
  finish
endif

syntax clear
colorscheme morning  " Dirty hack

syntax match pixivisionPChanA /##\+/
syntax match pixivisionPChanB /;;\+/
syntax match pixivisionPChanC /``\+/
syntax match pixivisionPChanD /< .*$/
syntax match pixivisionPChanE /::\+/
syntax match pixivisionPChanF /,,\+/

highlight pixivisionPChanA ctermfg=black ctermbg=black
highlight pixivisionPChanB ctermfg=darkgray ctermbg=darkgray
highlight pixivisionPChanC ctermfg=cyan ctermbg=cyan
highlight pixivisionPChanD ctermfg=black ctermbg=white cterm=bold
highlight pixivisionPChanE ctermfg=brown ctermbg=brown
highlight pixivisionPChanF ctermfg=white ctermbg=white

" TODO: Use nextgroup for category, date, url and text.
syntax match pixivisionHeader /^［.*］.*$/
syntax match pixivisionTitle /.*/ contained containedin=pixivisionHeader
syntax match pixivisionCategoryA /［.*］/ contained containedin=pixivisionHeader
syntax match pixivisionCategoryB /［.*］/ contained containedin=pixivisionHeader
syntax match pixivisionCategoryC /［.*］/ contained containedin=pixivisionHeader
syntax match pixivisionCategoryX /［.*］/ contained containedin=pixivisionHeader
syntax match pixivisionDate /^.*\<20\d\d\>.*$/
syntax match pixivisionUrl /^http.*/
" syntax match pixivisionText /.../

highlight pixivisionHeader ctermfg=black ctermbg=red
highlight pixivisionTitle ctermfg=black ctermbg=white cterm=bold
highlight pixivisionCategoryA ctermfg=white ctermbg=blue
highlight pixivisionCategoryB ctermfg=white ctermbg=darkgreen
highlight pixivisionCategoryC ctermfg=white ctermbg=brown
highlight pixivisionCategoryX ctermfg=white ctermbg=blue
highlight pixivisionDate ctermfg=darkgray ctermbg=gray
highlight pixivisionUrl ctermfg=darkgray ctermbg=gray
" highlight pixivisionText ctermfg=... ctermbg=...

let b:current_syntax = 'pixivision'
