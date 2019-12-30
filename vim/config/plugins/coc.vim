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

" K 查看文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

fu! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endf

" <leader>cf 打开coc配置文件
nnoremap <leader>cf :CocConfig<CR>

" <leader>cr 重命名
nmap <leader>cr <Plug>(coc-rename)

" <leader>cm 格式化当前buffer
nnoremap <leader>cm :Format<CR>
command! -nargs=0 Format :call CocAction('format')

" <leader>ci 排序import
nnoremap <leader>ci :OR
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" <leader>ca 列出所有诊断信息
nnoremap <silent> <leader>ca  :<C-u>CocList diagnostics<cr>

" <leader>ce 列出所有coc拓展
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>

" <leader>ce 列出所有coc命令
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" <leader>cs 列出当前文件的所有符号
nnoremap <silent> <leader>cs  :<C-u>CocList outline<cr>

" <leader>co 列出当前工作区的所有符号
nnoremap <silent> <leader>co  :<C-u>CocList -I symbols<cr>

" <leader>cp 重新打开上一次的搜索结果
nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>
