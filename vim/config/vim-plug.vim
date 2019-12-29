""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugins Management                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:is_nvim
    let plugin_path = '~/.config/nvim/plugged'
else
    let plugin_path = '~/.vim/plugged'
endif

call plug#begin(plugin_path)

" text
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
Plug 'Konfekt/FastFold', { 'for': 'python' }

" completion
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" appearance
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
" Plug 'edkolev/tmuxline.vim'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" other
Plug '~/.fzf' | Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'yianwillis/vimcdoc'
Plug 'kassio/neoterm'
Plug 'liuchengxu/vista.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vim-nerdtree/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

call plug#end()
