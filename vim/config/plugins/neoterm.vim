" 设置终端打开的位置
let g:neoterm_default_mod = 'below'

" 设置终端的大小
let g:neoterm_size = 15

" 设置滚动
let g:neoterm_autoscroll = 1

" gx{x} 发送文本到REPL
nmap gx <Plug>(neoterm-repl-send)
xmap gx <Plug>(neoterm-repl-send)
nmap gxx <Plug>(neoterm-repl-send-line)
