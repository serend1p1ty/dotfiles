let s:red    = ['#cc241d', 124]
let s:blue   = ['#458588', 66]
let s:blue1  = ['#0087d7', 32]
let s:green  = ['#98971a', 106]
let s:aqua   = ['#689d6a', 72]
let s:gray   = ['#a89984', 246]
let s:orange = ['#d65d0e', 166]
let s:bg     = ['#282828', 235]
let s:bg1    = ['#3c3836', 237]
let s:bg3    = ['#665c54', 241]
let s:bg4    = ['#7c6f64', 243]
let s:fg1    = ['#ebdbb2', 223]
let s:fg2    = ['#d5c4a1', 250]
let s:fg3    = ['#bdae93', 248]
let s:fg4    = ['#a89984', 246]

let s:palette = {'normal':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'inactive':{}, 'tabline':{}, 'terminal':{}}

" [foregroundColor, backgroundColor, fontType]
let s:palette.normal.left     = [[s:bg, s:green, 'bold'], [s:bg, s:bg4], [s:blue1, s:bg1]]
let s:palette.normal.right    = [[s:bg, s:green], [s:bg, s:bg4], [s:red, s:bg1], [s:blue1, s:bg1]]
let s:palette.normal.middle   = [[s:fg2, s:bg1]]

let s:palette.insert.left     = [[s:bg, s:blue, 'bold'], [s:bg, s:bg4], [s:blue1, s:bg1]]
let s:palette.insert.right    = [[s:bg, s:blue], [s:bg, s:bg4], [s:red, s:bg1], [s:blue1, s:bg1]]
let s:palette.insert.middle   = [[s:fg2, s:bg1]]

let s:palette.visual.left     = [[s:bg, s:orange, 'bold'], [s:bg, s:bg4], [s:blue1, s:bg1]]
let s:palette.visual.right    = [[s:bg, s:orange], [s:bg, s:bg4], [s:red, s:bg1], [s:blue1, s:bg1]]
let s:palette.visual.middle   = [[s:fg2, s:bg1]]

let s:palette.replace.left    = [[s:bg, s:aqua, 'bold'], [s:bg, s:bg4], [s:blue1, s:bg1]]
let s:palette.replace.right   = [[s:bg, s:aqua], [s:bg, s:bg4], [s:red, s:bg1], [s:blue1, s:bg1]]
let s:palette.replace.middle  = [[s:fg2, s:bg1]]

let s:palette.inactive.left   = [[s:bg4, s:bg1]]
let s:palette.inactive.right  = [[s:bg4, s:bg1]]
let s:palette.inactive.middle = [[s:bg4, s:bg1]]

let s:palette.terminal.left   = [[s:bg, s:green, 'bold']]
let s:palette.terminal.right  = [[s:bg, s:green]]
let s:palette.terminal.middle = [[s:fg2, s:bg1]]

let s:palette.tabline.left    = [[s:fg2, s:bg1]]
let s:palette.tabline.right   = [[s:bg, s:orange]]
let s:palette.tabline.tabsel  = [[s:bg, s:green]]
let s:palette.tabline.middle  = [[s:fg2, s:bg1]]

let g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:palette)
