" <F4> 开启/关闭quickfix窗口
noremap <silent> <F4> :call asyncrun#quickfix_toggle(8)<cr>

" 实时输出python程序运行结果
let $PYTHONUNBUFFERED=1

" 运行Asyncrun时打开quickfix窗口
if !exists('$TMUX')
    augroup vimrc
        autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
    augroup END
endif
