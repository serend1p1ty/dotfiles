""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ,代替<leader>
let mapleader = ","

" Q 执行存储在寄存器q中的宏
nnoremap Q @q

" Y 复制当前位置到行尾之间的内容
nnoremap Y y$

" <F12> 打开/关闭粘贴模式
set pastetoggle=<F12>

" \\ 关闭高亮显示搜索项
nnoremap <silent> \\ :nohlsearch<CR>

" 在全文范围内替换光标处的单词
nnoremap <leader>s :%s/\<<C-R><C-W>\>//g<left><left>

" <C-A> 全选
nnoremap <C-A> ggVG

" M 移动到匹配的符号处
noremap M %

" gm 移动到行尾
noremap gm $

" gn 移动到行首
noremap gn ^

" * 搜索并使光标保持在原位置
nnoremap * *N

""""""""""""""""
"  copy/paste  "
""""""""""""""""
" <C-C> 复制到系统粘贴板
nnoremap <C-C> "+yy
vnoremap <C-C> "+y

" <C-P> 从系统粘贴板粘贴
nnoremap <C-P> o<ESC>"+p
inoremap <C-P> <C-R>*
cnoremap <C-P> <C-R>*

"""""""""""""""
"  save/exit  "
"""""""""""""""
" <leader>q 退出文件
nnoremap <leader>q :q<CR>

" <leader>a 退出所有文件
nnoremap <leader>a :qa<CR>

" <leader>w 保存文件
nnoremap <leader>w :w<CR>

" <leader>x 保存并退出文件
nnoremap <leader>x :x<CR>

""""""""""
"  move  "
""""""""""
" <C-H> 插入模式下光标向左移动
inoremap <C-H> <left>

" <C-J> 插入模式下光标向下移动
" inoremap <C-J> <down>

" <C-K> 插入模式下光标向上移动
" inoremap <C-K> <up>

" <C-L> 插入模式下光标向右移动
inoremap <C-L> <right>

" <C-H> 移动到左边的窗口 
nnoremap <C-H> <C-W><C-H>
tnoremap <C-H> <C-W><C-H>

" <C-J> 移动到下边的窗口 
nnoremap <C-J> <C-W><C-J>
tnoremap <C-J> <C-W><C-J>

" <C-K> 移动到上边的窗口 
nnoremap <C-K> <C-W><C-K>
tnoremap <C-K> <C-W><C-K>

" <C-L> 移动到右边的窗口 
nnoremap <C-L> <C-W><C-L>
tnoremap <C-L> <C-W><C-L>

""""""""""""
"  insert  "
""""""""""""
" <SPACE>s 插入ipdb.set_trace()
nnoremap <SPACE>s Oimport ipdb; ipdb.set_trace(context=7)<ESC>

" <SPACE>j 在当前行的下方插入空行
nnoremap <SPACE>j o<ESC>k

" <SPACE>k 在当前行的上方插入空行
nnoremap <SPACE>k O<ESC>j

" <SPACE>h 在光标的左边插入空格
nnoremap <SPACE>h i<SPACE><ESC>l

" <SPACE>l 在光标的右边插入空格
nnoremap <SPACE>l a<SPACE><ESC>h

""""""""""""
"  buffer  "
""""""""""""
" [b 下一个缓冲区
nnoremap <silent> [b :bnext<CR>

" ]b 上一个缓冲区
nnoremap <silent> ]b :bprevious<CR>

" [d 删除当前缓存区
nnoremap <silent> [d :bdelete<CR>

"""""""""""
"  marks  "
"""""""""""
" <F3> 显示所有书签
" nnoremap <silent> <F3> :marks<CR>

" ]d 删除当前缓存区所有书签
" nnoremap <silent> ]d :delmarks!<CR>

""""""""""""""""""
"  command mode  "
""""""""""""""""""
" ; 进入命令行模式
noremap ; :

" <C-J> 下一条命令
cnoremap <C-J> <down>

" <C-K> 上一条命令
cnoremap <C-K> <up>

" <C-H> 光标向左移动
cnoremap <C-H> <left>

" <C-L> 光标向右移动
cnoremap <C-L> <right>

""""""""""""""""
"  very magic  "
""""""""""""""""
cnoremap %s %s/\v//g<left><left><left>
noremap :  :s/\v//g<left><left><left>

""""""""""""""
"  run code  "
""""""""""""""
" <F7> 调试
packadd termdebug
nnoremap <silent> <F7> :call Debug()<CR>
fu! Debug()
    exec "Termdebug %<"
endf

" <F6> 编译
nnoremap <silent> <F6> :call Compile()<CR>
fu! Compile()
    exec "w"
    if &filetype == 'cpp'
        let cmd = 'g++ -g -Wall -o %< -std=c++11 %'
    elseif &filetype == 'c'
        let cmd = 'gcc -g -Wall -o %< %'
    else
        return
    endif
    exec "AsyncRun! " . cmd
endf

" <F5> 运行
nnoremap <silent> <F5> :call Run()<CR>
fu! Run()
    if exists('$TMUX')
        exec "AsyncRun! tmux send-keys -t 0:0.1 C-P C-M"
    elseif &filetype == 'python'
        exec "w"
        exec "AsyncRun! python3 %"
    else
        exec "AsyncRun! $(VIM_FILEDIR)/$(VIM_FILENOEXT)"
    endif
endf

" <F3> 停止
nnoremap <silent> <F3> :call Stop()<CR>
fu! Stop()
    if exists('$TMUX')
        exec "AsyncRun! tmux send-keys -t 0:0.1 C-C"
    else
        exec "AsyncStop!"
    endif
endf
