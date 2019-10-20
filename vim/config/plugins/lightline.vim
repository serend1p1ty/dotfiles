let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left':  [['mode'], ['GitInfo'], ['CocStatus'], ['Filename']],
      \   'right': [['LineInfo'], ['FileEncodingFormat'], ['CocError'], ['CocWarn']],
      \ },
      \ 'inactive': {
      \   'left':  [['Filename']],
      \   'right': [['LineInfo']],
      \ },
      \ 'tabline': {
      \   'left':  [['Buffers']],
      \   'right': [['Sign']]
      \ },
      \ 'component': {
      \   'Sign': 'Love what you love',
      \ },
      \ 'component_expand': {
      \   'Buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_function': {
      \   'GitInfo':            'GetGitInfo',
      \   'Filename':           'GetFilenameIconStatus',
      \   'CocStatus':          'GetCocStatus',
      \   'LineInfo':           'GetLineInfo',
      \   'FileEncodingFormat': 'GetFileEncodingFormat',
      \   'CocError':           'GetCocError',
      \   'CocWarn':            'GetCocWarn',
      \ },
      \ 'component_type': {'Buffers': 'tabsel'},
      \ 'separator':      {'left': "\ue0b0", 'right': "\ue0b2"},
      \ 'subseparator':   {'left': "\ue0b1", 'right': "\ue0b3"}
      \ }

" 判断是否是某些特殊的buffer
fu! s:IsSpecialBuffer() abort
    return &buftype == 'terminal' || &filetype =~ '\v(help|startify|defx|undotree)'
endf

" GitInfo {{{
fu! GetGitInfo() abort
    if s:IsSpecialBuffer()
        return ""
    endif
    let gitBranch = get(g:, 'coc_git_status', "")
    let gitCount  = get(b:, 'coc_git_status', "")
    return trim(gitBranch . gitCount)
endf
" }}}

" Filename {{{
fu! s:GetFilename()
    let isReadonly = &readonly ? "🔒 " : ""
    return isReadonly . expand('%:t')
endf

fu! s:GetFilenameIcon()
    let filename = s:GetFilename()
    let icon = strlen(&filetype) ? " " . WebDevIconsGetFileTypeSymbol() : "no ft"
    return join([filename, icon], "")
endf

fu! s:IsModified() abort
    return s:IsSpecialBuffer() ?  ""  :
    \      &modified     ?  '' :
    \      &modifiable   ?  ""  : '-'
endf

fu! GetFilenameIconStatus() abort
    if s:IsSpecialBuffer()
        return ""
    endif
    if empty(expand('%:t'))
        return '[No Name]'
    endif
    let isModified   = s:IsModified()
    let filenameIcon = s:GetFilenameIcon()
    return empty(isModified) ? filenameIcon : filenameIcon . " " . isModified
endf
" }}}

" CocStatus {{{
fu! GetCocStatus() abort
    return get(g:, 'coc_status', '')
endf
" }}}

" LineInfo {{{
fu! GetLineInfo() abort
    return &filetype == 'help'     ? 'HELP':
    \      &filetype == 'defx'     ? 'DEFX':
    \      &filetype == 'startify' ? 'STARTIFY':
    \      &filetype == 'undotree' ? 'UNDOTREE':
    \      &buftype  == 'terminal' ? 'TERMINAL':
    \      printf('%d:%d ☰ %d%% ', line('.'), col('.'), 100 * line('.') / line('$'))
endf
" }}}

" FileEncodingFormat {{{
fu! GetFileEncodingFormat()
    if s:IsSpecialBuffer() || winwidth(0) <= 70
        return ""
    endif
    let encoding = empty(&fenc) ? &enc : &fenc 
    return encoding . '[' . &fileformat . ']'
endf
" }}}

" CocError {{{
fu! GetCocError()
    let error_sign = get(g:, 'coc_status_error_sign', "")
    let info       = get(b:, 'coc_diagnostic_info', {})
    if !empty(info) && get(info, 'error')
        return error_sign . info['error']
    endif
    return ""
endf
" }}}

" CocWarn {{{
fu! GetCocWarn() abort
    let warning_sign = get(g:, 'coc_status_warning_sign', "")
    let info         = get(b:, 'coc_diagnostic_info', {})
    if !empty(info) && get(info, 'warning')
        return warning_sign . info['warning']
    endif
    return ""
endf
" }}}
