" F2 开启/关闭目录树
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" 只剩下目录树时退出vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
