" >>> 插件管理 <<<---------------------------------------------------
" 使用vim-plug管理vim插件
call plug#begin('~/.vim/plugged')
" vim显示插件
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
" 解决tmux和vim复制粘贴
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
" 使用fzf
Plug '/home/chiebotgpuhq/.fzf'
Plug 'junegunn/fzf.vim'
" 文件管理器
Plug 'scrooloose/nerdtree'
" python缩进显示
Plug 'Yggdroot/indentLine'
" dracula主题
Plug 'dracula/vim', { 'as': 'dracula' }
" sneak插件用于跳转
Plug 'justinmk/vim-sneak'
" easymotion插件用于跳转
Plug 'easymotion/vim-easymotion'
call plug#end()
" >>> 插件设置 <<<----------------------------------------------------
"" PowerLine设置
"" powerline的安装路径，可能需要自行调整
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/ 
"" 设置vim状态栏数量为2，用于显示powerline的内容
"set laststatus=2  
"" 始终显示窗口上头的tabline
"set showtabline=2 
"" Hide the default mode text (e.g. -- INSERT -- below the statusline)
"set noshowmode    
"set t_Co=256

" >> markdown-preview 设置 <<----------------------------------------------
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = '/home/chiebotgpuhq/.config/markdown-preview-styles/styles/highlight/monokai.css'

" use a custom port to start server or random for empty
let g:mkdp_port = '8299'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'


" >>> 功能设置 <<<-----------------------------------------------------

" 将系统和vim剪贴板互通
set clipboard+=unnamedplus
" 显示行号
set nonumber

" 设置编码,支持中文乱码
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1,gb2312,cp936
" set termencoding=utf-8
set enc=utf8

" 突出显示当前行
" set cursorline
" 突出显示当前列
" set cursorcolumn
" 启用鼠标 设置为a启用鼠标，设置为v可以将鼠标赋值内容到剪切板
set mouse=v
set selection=exclusive
set selectmode=mouse,key
" 显示括号匹配
set showmatch

" 设置缩进
" 设置Tab长度为4空格
set tabstop=4
" 设置自动缩进长度为4空格
set shiftwidth=4
" 继承前一行的缩进方式，适用于多行注释
set autoindent
" 设置粘贴模式
" set paste " 直接这样设置在tmux中使用会导致失焦插入<F24><F25>
" 使用F10切换粘贴模式
set pastetoggle=<F10>

" 显示空格和tab
set listchars=tab:>-,trail:-
" 显示状态栏和光标当前位置
" 总是显示状态栏
" set laststatus=2
" 显示光标当前位置
set ruler
" 基于缩进进行代码折叠
set foldmethod=indent
" 启动 Vim 时关闭折叠
set nofoldenable

" >>> 性能设置 <<<------------------------------------------------------
" 使vimrc配置立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" 打开文件类型检测
filetype plugin indent on

" >>> 按键映射 <<<-----------------------------------------------------
let mapleader = "\<space>"
" === 功能映射 ===
" 将ctrl+s映射为保存文件
map <C-S> :w<CR>

" === 插件快捷键 ===
