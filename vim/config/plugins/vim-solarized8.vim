if isdirectory(expand('~/.vim/plugged/vim-solarized8'))
    set background=dark
    let g:solarized_term_italics = 1
    colorscheme solarized8
    highlight SignColumn guibg=#073642
endif
