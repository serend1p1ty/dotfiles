" 默认从coc获取符号
let g:vista_default_executive = 'coc'

" 当只剩下vista时退出vim
au BufEnter * if winnr("$") == 1 && vista#sidebar#IsVisible() | execute "normal! :q!\<CR>" | endif

" <F6> 打开/关闭Vista
nnoremap <F6> :Vista!!<CR>
