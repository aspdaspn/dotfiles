" Execute gVim.exe from WSL
" sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Vim/vim82/gvim.exe gvim.exe

" Language, encoding and colorscheme
set fileencodings=ucs-bom,utf-8,cp1251,koi8-r,cp1252,default,latin1
set encoding=utf-8
set guifont=consolas:h12
set fileformat=unix
colorscheme desert
if has('win32')
	set langmenu=en_US
	let $LANG = 'en_US'
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif
set spelllang=ru_yo,en_us,de_de

" Set backup directory for Windows
if has('win32')
	set backup
	set backupdir=$TEMP
	set backupskip=$TEMP
	set directory=$TEMP
	set undodir=$TEMP
	set writebackup
endif

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

" Tabs, indent and line numbers
set number
set tabstop=2
set shiftwidth=2
set autoindent

"Keyboard mapping
map <C-n> :NERDTreeToggle<CR>

"Set F3 for paste unformatted text
set pastetoggle=<F3>

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
