" 打开vista时焦点留在当前窗口
let g:vista_stay_on_open = 0

" 默认从coc获取符号
let g:vista_default_executive = 'coc'

" 当只剩下vista时退出vim
autocmd BufEnter * if winnr("$") == 1 && vista#sidebar#IsVisible() | execute "normal! :q!\<CR>" | endif

" <F6> 打开/关闭Vista
nnoremap <F6> :Vista!!<CR>
