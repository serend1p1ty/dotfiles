" <F2> 打开/关闭目录树
nnoremap <silent> <F2> :Defx -resume -toggle<CR>

" 外观设置
call defx#custom#option('_', {
	\ 'columns': 'indent:git:icons:filename',
	\ 'winwidth': 30,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ })

" 只剩下目录树时退出vim
autocmd WinEnter * if &ft == 'defx' && winnr('$') == 1 | q | endif

" 自定义功能键
autocmd FileType defx do WinEnter | call s:defx_my_settings()
fu! s:defx_my_settings() abort
    nnoremap <silent><buffer><expr> ~    defx#do_action('cd')
    nnoremap <silent><buffer><expr> h    defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> j    line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k    line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> l    <sid>defx_toggle_tree()
    nnoremap <silent><buffer><expr> e    defx#do_action('print')
    nnoremap <silent><buffer><expr> d    defx#do_action('remove')
    nnoremap <silent><buffer><expr> r    defx#do_action('rename')
    nnoremap <silent><buffer><expr> y    defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> K    defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N    defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> *    defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> .    defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> w    defx#do_action('call', 'DefxToggleWidth')
    nnoremap <silent><buffer><expr> <F5> defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <CR> defx#do_action('drop')

    nnoremap <silent><buffer><expr><nowait> \ defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr><nowait> c defx#do_action('copy')
    nnoremap <silent><buffer><expr><nowait> m defx#do_action('move')
    nnoremap <silent><buffer><expr><nowait> p defx#do_action('paste')
    nnoremap <silent><buffer><expr><nowait> <Space> defx#do_action('toggle_select') . 'j'
endf

" 打开目录/文件
fu! s:defx_toggle_tree() abort
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('drop')
endf

" 调整目录树宽度以便能看到名字最长的文件
fu! g:DefxToggleWidth(context) abort
    let l:max = 0
    let l:original = a:context['winwidth']
    for l:line in range(1, line('$'))
        let l:len = len(getline(l:line))
        if l:len > l:max
            let l:max = l:len
        endif
    endfo
    execute 'vertical resize '.(l:max == winwidth('.') ? l:original : l:max)
endf
