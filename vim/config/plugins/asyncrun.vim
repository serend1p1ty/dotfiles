" <F4> 开启/关闭quickfix窗口
noremap <F4> :call asyncrun#quickfix_toggle(8)<cr>

" 运行Asyncrun时打开quickfix窗口
augroup vimrc
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
