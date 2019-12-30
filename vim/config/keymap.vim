""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Keymaps                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 空格代替<leader>
let mapleader = " "

" 交换;和:
noremap ; :
noremap : ;

" <leader>] 清除所有断点
nnoremap <leader>] :g/import ipdb; ipdb.set_trace(context=7)/d<CR>

" Q 执行存储在寄存器q中的宏
nnoremap Q @q

" Y 复制当前位置到行尾之间的内容
nnoremap Y y$

" <F12> 打开/关闭粘贴模式
set pastetoggle=<F12>

" <backspace> 关闭高亮显示搜索项
nnoremap <silent> <backspace> :nohlsearch<CR>

" <C-A> 全选
nnoremap <C-A> ggVG

" * 搜索并使光标保持在原位置
nnoremap * *N

" 可视模式下粘贴不覆盖寄存器
vnoremap p pgvy

" 缩进时保持可视状态
vnoremap < <gv
vnoremap > >gv

""""""""""""""""
"  copy/paste  "
""""""""""""""""
" <C-C> 复制到系统粘贴板
nnoremap <C-C> "+yy
vnoremap <C-C> "+y

" <C-V> 从系统粘贴板粘贴
nnoremap <C-V> o<ESC>"+p
inoremap <C-V> <C-R>+
cnoremap <C-V> <C-R>+

"""""""""""""""
"  save/exit  "
"""""""""""""""
" <leader>q 退出文件
nnoremap <leader>q :q<CR>

" <leader>a 退出所有文件
nnoremap <leader>a :qa<CR>

" <leader>w 保存文件
nnoremap <leader>w :w!<CR>

" <leader>x 保存并退出文件
nnoremap <leader>x :x<CR>

""""""""""
"  move  "
""""""""""
inoremap <C-H> <left>
cnoremap <C-H> <left>
nnoremap <C-H> <C-W><C-H>

inoremap <C-J> <down>
cnoremap <C-J> <down>
nnoremap <C-J> <C-W><C-J>

inoremap <C-K> <up>
cnoremap <C-K> <up>
nnoremap <C-K> <C-W><C-K>

inoremap <C-L> <right>
cnoremap <C-L> <right>
nnoremap <C-L> <C-W><C-L>

if has('nvim')
    augroup term_move
        au!
        au TermOpen * tnoremap <buffer> <C-H> <C-\><C-N><C-W><C-H>
        au TermOpen * tnoremap <buffer> <C-J> <C-\><C-N><C-W><C-J>
        au TermOpen * tnoremap <buffer> <C-K> <C-\><C-N><C-W><C-K>
        au TermOpen * tnoremap <buffer> <C-L> <C-\><C-N><C-W><C-L>
        au TermOpen * tnoremap <buffer> <Esc> <C-\><C-N>
    augroup END

    augroup fzf
        au!
        au FileType fzf tunmap <buffer> <C-H>
        au FileType fzf tunmap <buffer> <C-J>
        au FileType fzf tunmap <buffer> <C-K>
        au FileType fzf tunmap <buffer> <C-L>
        au FileType fzf tunmap <buffer> <Esc>
    augroup END
endif


""""""""""""
"  insert  "
""""""""""""
" zp 插入ipdb.set_trace()
nnoremap zp Oimport ipdb; ipdb.set_trace(context=7)<ESC>

" zj 在当前行的下方插入空行
nnoremap zj o<ESC>k

" zk 在当前行的上方插入空行
nnoremap zk O<ESC>j

" zh 在光标的左边插入空格
nnoremap zh i<SPACE><ESC>l

" zl 在光标的右边插入空格
nnoremap zl a<SPACE><ESC>h

""""""""""""
"  buffer  "
""""""""""""
" [b 下一个缓冲区
nnoremap <silent> [b :call SwitchBuffer(1)<CR>

" ]b 上一个缓冲区
nnoremap <silent> ]b :call SwitchBuffer(-1)<CR>
fu! SwitchBuffer(offset)
    let buflist = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let len = len(buflist)
    let current = bufnr('%')
    for i in range(0, len - 1)
        if buflist[i] == current
            let ind = (i + a:offset + len) % len
            while bufname(buflist[ind]) =~ '^term://'
                let ind = (ind + a:offset + len) % len
            endwhile
            let ind = buflist[ind]
        endif
    endfor
    exec "buffer " . ind
endf

" [d 删除当前缓存区
nnoremap <silent> [d :call DeleteBuffer()<CR>
fu! DeleteBuffer()
    let bufNo = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    if bufNo > 1
        exec "bp | bd #"
    else
        exec "bd"
    endif
endf

""""""""""""""""
"  substitute  "
""""""""""""""""
cnoremap %s        %s/\v//g<left><left><left>
vnoremap <leader>s :s/\v//g<left><left><left>
nnoremap <leader>s :%s/\<<C-R><C-W>\>//g<left><left>

""""""""""""""
"  run code  "
""""""""""""""
" <F5> 运行
nnoremap <silent> <F5> :call Run()<CR>
fu! Run()
    exec "w"
    exec "Topen"
    if &filetype == 'python'
        exec "T python3 %"
    endif
    exec "stopinsert"
endf

" <F4> 反转终端
nnoremap <silent> <F4> :Ttoggle<CR><C-W><C-J>
tnoremap <silent> <F4> <C-\><C-N>:Ttoggle<CR>

" <F3> 彻底关闭终端
nnoremap <silent> <F3> :Tclose!<CR>
tnoremap <silent> <F3> <C-\><C-N>:Tclose!<CR>
