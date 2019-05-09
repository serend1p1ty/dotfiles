" 确定平台
silent fu! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endf
silent fu! WINDOWS()
    return has('win32') || has('win64')
endf
silent fu! OSX()
    return has('macunix')
endf
let g:is_linux   = LINUX()
let g:is_windows = WINDOWS()
let g:is_osx     = OSX()
let g:is_nvim    = has('nvim')

" 获得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 加载基础配置
exec 'source' s:home.'/basic.vim'

" 加载按键映射
exec 'source' s:home.'/keymap.vim'

" 加载插件
exec 'source' s:home.'/vim-plug.vim'

" 加载插件配置文件
for config_file in split(glob(s:home.'/plugins/*.vim'), '\n')
    exec 'source' config_file
endfo
