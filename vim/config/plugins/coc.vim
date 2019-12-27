" <TAB> 跳转至下一个占位符
let g:coc_snippet_next = '<TAB>'

" <S-TAB> 跳转至上一个占位符
let g:coc_snippet_prev = '<S-TAB>'

" 安装的拓展
let g:coc_global_extensions = ['coc-snippets','coc-json','coc-python','coc-highlight']

" <TAB> 选择下一项
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

fu! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endf

" <S-TAB> 选择上一项
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" <CR> 确定选择
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 高亮光标下的单词
autocmd CursorHold * silent call CocActionAsync('highlight')

" [c 下一个诊断错误
nmap <silent> [c <Plug>(coc-diagnostic-next)

" ]c 上一个诊断错误
nmap <silent> ]c <Plug>(coc-diagnostic-prev)

" gd 跳转到定义
nmap <silent> gd <Plug>(coc-definition)

" gr 跳转到引用
nmap <silent> gr <Plug>(coc-references)

" <leader>cc 打开coc命令面板
nnoremap <leader>cc :CocCommand<CR>

" <leader>cf 打开coc配置文件
nnoremap <leader>cf :CocConfig<CR>
