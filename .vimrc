" >>> 插件管理 <<<---------------------------------------------------
" 使用vim-plug管理vim插件
call plug#begin('~/.vim/plugged')
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

" >>> 功能设置 <<<-----------------------------------------------------

" 将系统和vim剪贴板互通
set clipboard+=unnamed
" 显示行号
set number

" 设置编码,支持中文乱码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

" 突出显示当前行
" set cursorline
" 突出显示当前列
" set cursorcolumn
" 启用鼠标
set mouse=a
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
set paste
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
" === 功能映射 ===
" 将ctrl+s映射为保存文件
map <C-S> :w<CR>


