" 第一次进入插入模式时才加载ycm
augroup load_ycm
    autocmd!
    autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! load_ycm
augroup END

" 输入两个字符后开启语义补全
let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }
