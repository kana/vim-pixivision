if exists('b:current_syntax')
  finish
endif

syntax clear
colorscheme morning  " Dirty hack

syntax match pixivisionPChanA /##\+/
syntax match pixivisionPChanB /;;\+/
syntax match pixivisionPChanC /``\+/
syntax match pixivisionPChanD /< .*$/

highlight pixivisionPChanA ctermfg=black ctermbg=black
highlight pixivisionPChanB ctermfg=cyan ctermbg=cyan
highlight pixivisionPChanC ctermfg=white ctermbg=white
highlight pixivisionPChanD ctermfg=black ctermbg=white

let b:current_syntax = 'pixivision'
