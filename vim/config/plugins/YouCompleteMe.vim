" 输入两个字符后开启语义补全
let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }

" 指定python解释器的路径
if g:is_linux
    let g:ycm_python_binary_path = '/usr/bin/python3'
else
    let g:ycm_python_binary_path = 'C:\\Users\\GooCoder\\AppData\\Local\\Programs\\Python\\Python37\\python.exe'
endif

" 让ycm从注释和字符串中收集标识符信息
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" 语义补全最大候选条目
let g:ycm_max_num_candidates = 10

" c族语言补全设置
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" 禁止每次询问是否加载ycm_extra_conf
let g:ycm_confirm_extra_conf = 0

" 错误提示标志
let g:ycm_error_symbol = '•'

" 警告提示标志
let g:ycm_warning_symbol = '•'

" 调试YCM
" let g:ycm_log_level = 'debug'

" 跳转到定义，如果定义不可访问，就跳转到声明
nnoremap <leader>g :YcmCompleter GoTo<CR>
