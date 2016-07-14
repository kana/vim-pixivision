if exists('b:did_ftplugin')
  finish
endif

setlocal formatoptions+=m
setlocal textwidth=70
setlocal buftype=nofile
setlocal noswapfile

let b:did_ftplugin = 1
