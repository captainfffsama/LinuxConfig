" 使用vim-plug管理vim插件
call plug#begin('~/.vim/plugged')
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
call plug#end()

" 将系统和vim剪贴板互通
set clipboard+=unnamed

" 显示行号
set number
