" 使用vim-plug管理vim插件
call plug#begin('~/.vim/plugged')
" 解决tmux和vim复制粘贴
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
" 使用fzf
Plug '/home/chiebotgpuhq/.fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" 将系统和vim剪贴板互通
set clipboard+=unnamed

" 显示行号
set number
