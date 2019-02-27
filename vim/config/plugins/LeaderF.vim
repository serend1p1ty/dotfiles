" <leader>fi 搜索当前目录下的文件
let g:Lf_ShortcutF = '<leader>fi'

" <leader>fm 搜索最近使用过的文件
nnoremap <leader>fm :Leaderf mru<CR>

" <leader>fc 搜索历史命令
nnoremap <leader>fc :Leaderf cmdHistory<CR>

" <leader>ff 搜索当前文件中定义的函数
nnoremap <leader>ff :Leaderf function<CR>

" <leader>fw 搜索光标处的单词
noremap <leader>fw :<C-U><C-R>=printf("Leaderf! rg -e %s", expand("<cword>"))<CR>

" <leader>fr 重新打开上一次的搜索结果
noremap <leader>fr :<C-U>Leaderf! rg --recall<CR>
