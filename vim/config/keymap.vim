""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" space代替<leader>
let mapleader=" "
nnoremap <SPACE> <NOP>

" F7 打开/关闭粘贴模式
set pastetoggle=<F7>

" \\ 关闭高亮显示搜索项
nnoremap <silent> \\ :nohlsearch<CR>

" 在全文范围内替换光标处的单词
nnoremap <leader>s :%s/\<<C-R><C-W>\>//g<left><left>

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

""""""""""""
"  insert  "
""""""""""""
" zs 插入ipdb.set_trace()
nnoremap zs Oimport ipdb; ipdb.set_trace(context=7)<ESC>

" zj/k 在当前行的下/上方插入空行
nnoremap zj o<ESC>k
nnoremap zk O<ESC>j

" zh/l 在光标的左/右边插入空格
nnoremap zh i<SPACE><ESC>l
nnoremap zl a<SPACE><ESC>h

""""""""""""
"  buffer  "
""""""""""""
" F3 显示缓冲区
nnoremap <F3> :buffers<CR>

" [b 下一个缓冲区
nnoremap [b :bnext<CR>

" ]b 上一个缓冲区
nnoremap ]b :bprevious<CR>

" [d 删除当前缓存区
nnoremap [d :bdelete<CR>

" ]d 删除指定缓存区
nnoremap ]d :bdelete

""""""""""""""""""
"  command mode  "
""""""""""""""""""
" ;和:功能互换
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" <C-J> 下一条命令
cnoremap <C-J> <down>

" <C-K> 上一条命令
cnoremap <C-K> <up>

""""""""""""""
"  run code  "
""""""""""""""
" <F5> 在tmux的另一个窗格中执行上一条命令
nnoremap <F5> :call RunCode()<CR>
fu! RunCode()
    exec "w"
    exec "AsyncRun! tmux send-keys -t 0:0.1 C-P C-J"
endf
