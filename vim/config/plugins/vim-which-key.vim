let g:leader_map = {
      \ 'name' : '+Leader-Key',
      \ 'w'    : '保存文件',
      \ 'x'    : '保存并退出文件',
      \ 'q'    : '退出文件',
      \ 'a'    : '退出所有文件',
      \ 's'    : '全文范围内替换光标处的单词',
      \ 'j'    : '跳转到变量或函数的定义处',
      \ 'f'    : {
               \ 'name' : '+LeaderF',
               \ 'i'    : '搜索当前目录下的文件',
               \ 'm'    : '搜索最近使用过的文件',
               \ 'c'    : '搜索历史命令',
               \ 'f'    : '搜索当前文件中定义的函数',
               \ 'w'    : '搜索光标处的单词',
               \ 'r'    : '重新打开上一次的搜索结果',
               \ },
      \ 'b'    : 'which_key_ignore',
      \ 'd'    : 'which_key_ignore',
\ }

" let g:g_map = {
"       \ 'name' : '+G-Key',
"       \ 'm'    : '移动到行尾',
"       \ 'n'    : '移动到行首',
"       \ 'cc'   : '注释当前行',
"       \ 'c'    : '注释文本对象',
"       \ 'a'    : '排列文本',
"       \ 'x'    : 'which_key_ignore',
" \ }

let g:space_map = {
      \ 'name' : '+Space-Key',
      \ 's'    : '在当前行的上方插入断点',
      \ 'j'    : '在当前行的下方插入空行',
      \ 'k'    : '在当前行的上方插入空行',
      \ 'h'    : '在当前光标的左边插入空格',
      \ 'l'    : '在当前光标的右边插入空格',
\ }

let g:lbracket_map = {
      \ 'name' : '+Left-Bracket-Key',
      \ 'b'    : '切换到下一个缓存区',
      \ 'd'    : '删除当前缓存区',
      \ '"'    : 'which_key_ignore',
      \ ']'    : 'which_key_ignore',
      \ '['    : 'which_key_ignore',
\ }

let g:rbracket_map = {
      \ 'name' : '+Right-Bracket-Key',
      \ 'b'    : '切换到上一个缓存区',
      \ 'd'    : '删除当前缓存区的所有书签',
      \ '"'    : 'which_key_ignore',
      \ ']'    : 'which_key_ignore',
      \ '['    : 'which_key_ignore',
\ }

call which_key#register(',', "g:leader_map")
" call which_key#register('g', "g:g_map")
call which_key#register('<space>', "g:space_map")
call which_key#register('[', "g:lbracket_map")
call which_key#register(']', "g:rbracket_map")
nnoremap <silent> <leader> :<c-u>WhichKey ','<CR>
" nnoremap <silent> g        :<c-u>WhichKey 'g'<CR>
nnoremap <silent> <space>  :<c-u>WhichKey '<space>'<CR>
nnoremap <silent> [        :<c-u>WhichKey '['<CR>
nnoremap <silent> ]        :<c-u>WhichKey ']'<CR>
