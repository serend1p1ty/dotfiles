set nocompatible                " 关闭vi兼容模式

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Plugins Management                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:basic = 1
let s:appearance = 1
let s:text = 1
let s:python = 1
let s:git = 1

call plug#begin('~/.vim/plugged')

if s:basic > 0
    " 目录树
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

    " 增强tab
    Plug 'ervandew/supertab'

    " 搜索文件
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

    " 异步执行
    Plug 'skywind3000/asyncrun.vim'

    " 快速注释
    Plug 'scrooloose/nerdcommenter'
endif

if s:appearance > 0
    " 配色方案
    Plug 'cocopon/iceberg.vim'
    Plug 'lifepillar/vim-solarized8'

    " 彩虹括号
    Plug 'luochen1990/rainbow'

    " 状态栏
    Plug 'vim-airline/vim-airline'
endif

if s:text > 0
    " 代码片段补全
    Plug 'SirVer/ultisnips'
    Plug 'ppnman/vim-snippets'

    " 自动括号
    Plug 'jiangmiao/auto-pairs'

    " 操作成对符号
    Plug 'tpope/vim-surround'

    " 文本对象
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'sgur/vim-textobj-parameter'
    Plug 'bps/vim-textobj-python', { 'for': 'python' }
    Plug 'kana/vim-textobj-function', { 'for': ['c','cpp','vim','java'] }
endif

if s:python > 0
    " 代码提示
    Plug 'davidhalter/jedi-vim', { 'for': 'python' }

    " 代码检错
    Plug 'w0rp/ale', { 'for': 'python' }

    " 代码格式化
    Plug 'Chiel92/vim-autoformat', { 'for': 'python' }

    " 显示缩进线
    Plug 'Yggdroot/indentLine', { 'for': 'python' }
endif

if s:git > 0
    " 显示gitdiff
    Plug 'mhinz/vim-signify'

    " git命令包装器
    Plug 'tpope/vim-fugitive'
endif

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Basic settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      " 显示行号
set cursorline                  " 高亮光标所在行
set backspace=indent,eol,start  " Backspace删除
set noshowmode                  " 关闭左下角类似"-- INSERT --"的状态提示
set nowrap                      " 不自动换行
set signcolumn=yes              " 一直显示符号列
syntax enable                   " 语法高亮

""""""""""""""""
"  true color  "
""""""""""""""""
set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum
set termguicolors

"""""""""
"  tab  "
"""""""""
set softtabstop=4               " 敲入tab键时实际占有的列数
set expandtab                   " 敲入tab键时将其转化为空格

""""""""""""
"  indent  "
""""""""""""
set shiftwidth=4                " <<和>>缩进的列数
set autoindent                  " 自动缩进
filetype plugin indent on       " 根据文件类型设置缩进风格

""""""""""""
"  search  "
""""""""""""
set ignorecase                  " 搜索时不区分大小写
set smartcase                   " 搜索时智能判断大小写
set hlsearch                    " 高亮匹配项

""""""""""""""
"  encoding  "
""""""""""""""
set encoding=utf-8              " 内部工作编码
set fileencoding=utf-8          " 保存文件默认编码
set fileencodings=utf-8,gbk     " 打开文件时按照下面的顺序尝试识别编码

""""""""""
"  fold  "
""""""""""
set fdm=indent                  " 代码折叠默认使用缩进
set foldlevel=99                " 默认打开所有折叠

""""""""""""""""
"  wildignore  "
""""""""""""""""
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ,代替<leader>
let mapleader=","

" F7 打开/关闭粘贴模式
set pastetoggle=<F7>

" \\ 关闭高亮显示搜索项
nnoremap <silent> \\ :nohlsearch<CR>

" <leader>s 插入ipdb.set_trace()
nnoremap <leader>s Oimport ipdb; ipdb.set_trace(context=7)<ESC>

" <C-L> 插入模式下向右移动
inoremap <C-L> <right>

" zj/k 在当前行的下一行/上一行插入新行，并进入普通模式
nnoremap zj o<ESC>k
nnoremap zk O<ESC>j

"""""""""""""""
"  save/exit  "
"""""""""""""""
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qa<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>

"""""""""""""""""
"  multiwindow  "
"""""""""""""""""
" <C-H/J/K/L> 窗口之间的移动
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" <leader>o 只保留当前窗口
nnoremap <leader>o :only<CR

""""""""""""
"  buffer  "
""""""""""""
" F3 显示缓存区
nnoremap <F3> :buffers<CR>

" [b 进入下一个缓存区
nnoremap [b :bnext<CR>

" ]b 进入上一个缓存区
nnoremap ]b :bprevious<CR>

"""""""""""""""""""
"  command model  "
"""""""""""""""""""
" ; 开启命令行模式
nnoremap ; :

" <C-J> 下一条命令
cnoremap <C-J> <down>

" <C-H> 上一条命令
cnoremap <C-K> <up>

"""""""""
"  run  "
"""""""""
" <F5> 执行代码
nnoremap <F5> :call RunCode()<CR>
func! RunCode()
    exec "w"
    if &filetype == 'sh'
        exec "AsyncRun! sh %"
    elseif &filetype == 'python'
        exec "AsyncRun! python3 %"
    endif
endfunc

""""""""""""""""""
"  requirements  "
""""""""""""""""""
" F10 为vim插件安装必要的依赖
nnoremap <F10> :call InstallRequirements()<CR>
func! InstallRequirements()
    let req = {"pip3": ['autopep8', 'flake8']}
    let cmd_map = {"pip3": "sudo pip3 install -i https://pypi.douban.com/simple/"}

    execute "! echo '>>> Installing essential softwares for vim plugins.'"
    for [src, pkgs] in items(req)
        for pkg in pkgs
            let cmd = cmd_map[src] . " " . pkg
            execute "!" . cmd
        endfor
    endfor
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Plugins Configuration                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""
"  jedi-vim  "
""""""""""""""
" 在vim的命令行中显示函数签名
let g:jedi#show_call_signatures = "2"

""""""""""""""
"  nerdtree  "
""""""""""""""
" F2 开启/关闭目录树
nnoremap <silent> <F2> :NERDTreeToggle<CR>

" 只剩下目录树时退出vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""
"  ale  "
"""""""""
" 保存文件时自动检查语法错误
let g:ale_fix_on_save = 1

" 语法错误提示信息的输出格式
let g:ale_echo_msg_format = '[%linter%]-[%severity%]-%s '

" 自定义错误提示符
let g:ale_sign_error = '•'

" 自定义警告提示符
let g:ale_sign_warning = '•'

""""""""""""""
"  asyncrun  "
""""""""""""""
" 运行AsyncRunStart时打开quickfix窗口
augroup MyGroup
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END

" F6 打开/关闭quickfix窗口
noremap <F6> :call asyncrun#quickfix_toggle(8)<CR>

""""""""""""""""""""
"  vim-autoformat  "
""""""""""""""""""""
" F4 代码格式化
noremap <F4> :Autoformat<CR>

""""""""""""""
"  supertab  "
""""""""""""""
" 默认根据上下文补全
let g:SuperTabDefaultCompletionType = "context"

"""""""""""""""""""
"  nerdcommenter  "
"""""""""""""""""""
" 在注释符后面加一个空格
let g:NERDSpaceDelims = 1

"""""""""""""
"  LeaderF  "
"""""""""""""
" <leader>m MRU(most recently used)文件搜索
nnoremap <leader>m :LeaderfMru<CR>

" [c 历史命令搜索
nnoremap [c :LeaderfHistoryCmd<CR>

" [f 函数搜索
nnoremap [f :LeaderfFunction<CR>

" <leader>F 搜索光标处的单词
noremap <leader>F :<C-U><C-R>=printf("Leaderf! rg -e %s", expand("<cword>"))<CR>

" re 重新打开上一次的搜索结果
noremap re :<C-U>Leaderf! rg --recall<CR>

"""""""""""""
"  rainbow  "
"""""""""""""
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

""""""""""""""""
"  indentLine  "
""""""""""""""""
" 默认关闭
let g:indentLine_enabled = 0

" 缩进线字符设置
let g:indentLine_char = '¦'

" F12 打开/关闭缩进线显示
nnoremap <F12> :IndentLinesToggle<CR>

"""""""""""""""""
"  colorscheme  "
"""""""""""""""""
if isdirectory(expand('~/.vim/plugged/vim-solarized8'))
    set background=dark
    let g:solarized_term_italics = 1
    colorscheme solarized8
    highlight SignColumn guibg=#073642
endif
