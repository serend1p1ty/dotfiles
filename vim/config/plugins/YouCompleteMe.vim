" 第一次进入插入模式时才加载ycm
" augroup load_ycm
"     autocmd!
"     autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
" augroup END

" 输入两个字符后开启语义补全
let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }

" 指定python解释器的路径
let g:ycm_python_binary_path = '/usr/bin/python3'

" 让ycm从注释和字符串中收集标识符信息
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" 跳转到定义，如果定义不可访问，就跳转到声明
nnoremap <leader>j :YcmCompleter GoTo<CR>
