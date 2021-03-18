" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Install plugins
call plug#begin('~/.vim/plugged')
  Plug 'joshdick/onedark.vim'
  Plug 'preservim/nerdtree'
  Plug 'dense-analysis/ale'
  Plug 'airblade/vim-gitgutter'
call plug#end()
