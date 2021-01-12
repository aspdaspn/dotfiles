" Specify a directory for plugins and Installation scripts
" Linux: 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Windows (Power Shell): 
" iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
" ni $HOME/vimfiles/autoload/plug.vim -Force
if has('unix')
	call plug#begin('~/.vim/plugged')
endif

if has('win32')
	call plug#begin('%HOMEPATH%\vimfiles\plugged')
endif

call plug#begin()
	Plug 'preservim/nerdtree'
call plug#end()

" Initialize plugin system
call plug#end()

set fileencodings=ucs-bom,utf-8,cp1251,koi8-r,cp1252,default,latin1
colorscheme desert
set number
set tabstop=2
set shiftwidth=2
set autoindent
map <C-n> :NERDTreeToggle<CR>
"Set F3 for paste unformatted text
set pastetoggle=<F3>
" Execute gVim.exe from WSL
" sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Vim/vim82/gvim.exe gvim.exe
