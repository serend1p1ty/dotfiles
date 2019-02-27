" 获得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 定义一个用来加载文件的命令
command! -nargs=1 LoadScript exec 'source '.s:home.'/'.'<args>'

" 加载基础配置
LoadScript basic.vim

" 加载按键映射
LoadScript keymap.vim

" 加载插件
LoadScript vim-plug.vim

" 加载插件配置文件
let plugin_config_path = s:home.'/plugins'
let file_list = split(globpath(plugin_config_path,'*.vim'),'\n')
for file in file_list
    exec 'source' fnameescape(file)
endfo
