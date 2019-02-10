" FSE-vim基本配置部分
"=============================================================================================================
set nocompatible                " 关闭兼容模式
set encoding=utf-8              " utf-8编码
set fileencodings=utf-8,gbk     " 打开文件时自动识别编码格式
set fileformat=unix             " 以unix的格式保存文件
set ambiwidth=double            " 中文引号显示
set number                      " 显示行号
set softtabstop=4               " 敲入tab键时实际占有的列数
set expandtab                   " 敲入tab键时将其转化为空格
set shiftwidth=4                " <<和>>时缩进的列数
set ignorecase                  " 在搜索时不区分大小写
set cursorline                  " 高亮光标所在的行
set hlsearch                    " 检索时高亮显示匹配项
set backspace=indent,eol,start  " Backspace删除
let python_highlight_all=1      " 高亮python语法
set completeopt=longest,menu    " 关闭函数预览窗口
set noshowmode                  " 关闭左下角类似"-- INSERT --"的状态提示
filetype plugin indent on       " 根据文件类型设置缩进风格
syntax enable                   " 语法高亮

" vim开启真彩色
if has("termguicolors")
    " 修复vim的bug
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum

    " 开启真彩色
    set termguicolors
endif

" ;开启命令行模式
nnoremap ; :

" ,代替<leader>
let mapleader=","

" F10 打开/关闭粘贴模式
set pastetoggle=<F10>

" ,q/a/w/x 退出/退出所有/保存/保存并退出文件
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qa<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>

" ,o只保留当前窗口
nnoremap <leader>o :only<CR>

" ,t只保留当前标签页
nnoremap <leader>t :tabo<CR>

" ,n/p进入下一个/上一个标签页
nnoremap <leader>n :tabn<CR>
nnoremap <leader>p :tabp<CR>

" \h关闭高亮显示搜索项
nnoremap \h :nohlsearch<CR>

" 插入模式下向右移动
inoremap <C-L> <right>

" <F5>执行代码
noremap <F5> :call RunCode()<CR>

" 普通模式下多窗口之间的移动
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 代码超过80行时用下划线标识
au BufRead,BufNewFile *.* 2match Underlined /.\%81v/

" GVIM设置
if has("gui_running")
    set guioptions-=m           " 关闭菜单栏
    set guioptions-=T           " 关闭工具栏
    set guioptions-=l           " 关闭左边滚动条
    set guioptions-=L           " 关闭垂直分隔窗口左边滚动条
    set guioptions-=r           " 关闭右边滚动条
    set guioptions-=R           " 关闭垂直分隔窗口右边滚动条
endif
"=============================================================================================================

" FSE-vim函数部分
"=============================================================================================================
" 为vim插件安装必要的包
function! InstallRequirements()
    let req = {"pip3": ['autopep8', 'flake8']}
    let cmd_map = {"pip3": "sudo pip3 install -i https://pypi.douban.com/simple/"}

    execute "! echo '>>> Installing essential softwares for vim plugins.'"
    for [src, pkgs] in items(req)
        for pkg in pkgs
            let cmd = cmd_map[src] . " " . pkg
            execute "!" . cmd
        endfor
    endfor
endfunction

" 保存并执行代码
function! RunCode()
    exec "w"
    if &filetype == 'sh'
        exec "AsyncRun! sh %"
    elseif &filetype == 'python'
        exec "AsyncRun! python3 %"
    endif
endfunction
"=============================================================================================================

" FSE-vim插件管理部分
"=============================================================================================================
" 第一次进入vim自动加载插件
if empty(glob('~/.vim/plugged'))
    autocmd VimEnter * PlugUpdate
endif

call plug#begin('~/.vim/plugged')

" python代码自动补全插件
Plug 'davidhalter/jedi-vim', { 'for':  'python' }
" 在vim的命令行里显示函数签名(即函数参数提示)
let g:jedi#show_call_signatures = "2"

" 目录树插件
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" F2 开启/关闭目录树
nnoremap <silent> <F2> :NERDTreeToggle<CR>
" 当只剩下NERDtree时退出vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 语法检错插件
Plug 'w0rp/ale', { 'for':  'python' }
" 保存文件时自动检查语法错误
let g:ale_fix_on_save = 1
" 语法错误提示信息的输出格式
let g:ale_echo_msg_format = '[%linter%]-[%severity%]-%s '
" 自定义错误提示符
let g:ale_sign_error = '•'
" 自定义警告提示符
let g:ale_sign_warning = '•'

" 异步执行代码插件
Plug 'skywind3000/asyncrun.vim'
" 每次运行AsyncRunStart的时候自动打开quickfix窗口
augroup MyGroup
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
augroup END
" F9 打开/关闭quickfix窗口
noremap <F9> :call asyncrun#quickfix_toggle(8)<cr>

" 代码规范化插件
Plug 'Chiel92/vim-autoformat', { 'for':  'python' }
" F3 代码格式化
noremap <F3> :Autoformat<CR>

" 增强tab功能插件
Plug 'ervandew/supertab'
" 根据当前文本自动选择补全方式
let g:SuperTabDefaultCompletionType = "context"

" 快速注释插件
Plug 'scrooloose/nerdcommenter'
" 在注释符后面加一个空格
let g:NERDSpaceDelims = 1
" 允许注释空行
let g:NERDCommentEmptyLines = 1

" 查找文件插件
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" ,m MRU(most recently used)文件搜索
nnoremap <leader>m :LeaderfMru<CR>
" 搜索结果显示框高度为全屏的30%
let g:Lf_WindowHeight=0.3

" 彩虹括号插件
Plug 'luochen1990/rainbow'
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

" 显示缩进线插件
Plug 'Yggdroot/indentLine', { 'for': 'python' }
" 默认关闭
let g:indentLine_enabled = 0
" 缩进线字符设置
let g:indentLine_char = '¦'
" F12 打开/关闭缩进线显示
nnoremap <F12> :IndentLinesToggle<CR>

" 自动补全括号插件
Plug 'jiangmiao/auto-pairs'

" 状态栏插件
Plug 'vim-airline/vim-airline'

" vim主题插件
Plug 'cocopon/iceberg.vim'

call plug#end()
"=============================================================================================================

" 设置vim主题，这句话要在插件加载结束之后
if isdirectory(expand('~/.vim/plugged/iceberg.vim'))
    colorscheme iceberg
endif
