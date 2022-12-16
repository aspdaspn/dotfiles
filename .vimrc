" Execute gVim.exe from WSL
" sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Vim/vim82/gvim.exe gvim.exe

" Disable VI compatibility
set nocompatible

" Initialize plugin system "Plug"
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
	call plug#begin('$HOMEDRIVE\$HOMEPATH\vimfiles\plugged')
endif
" List of plugins
	Plug 'preservim/nerdtree'
	Plug 'christoomey/vim-tmux-navigator'
    Plug 'sheerun/vim-polyglot'		" Language highlights
    Plug 'jiangmiao/auto-pairs'     " auto pair completion, brackets, quotes, etc.
    Plug 'preservim/tagbar'         " Tagbar: a class outline viewer. Install ctags
    Plug 'dyng/ctrlsf.vim'          " ctrlsf.vim Search plug-in. Install ack to use it
	Plug 'derekwyatt/vim-fswitch'	" Switching between .h and .cpp files
    Plug 'derekwyatt/vim-protodef'  " Prototypes from C++ header
    Plug 'Yggdroot/indentLine'      " Indent Levels 
    Plug 'tpope/vim-fugitive'       " Git plugin
"    Plug 'ycm-core/YouCompleteMe'   " YouCompleteMe
    Plug 'morhetz/gruvbox'          " Colorsheme

call plug#end()

" Disable filetype identification
filetype off

" Language, mouse support, encoding and colorscheme
set fileencodings=ucs-bom,utf-8,cp1251,koi8-r,cp1252,default,latin1
set encoding=utf-8
set guifont=consolas:h12
set fileformats=unix,dos
colorscheme gruvbox
set bg=dark
set t_ut=       "clearing uses the current background color, it is the TMUX color fix

"Split position
set splitright
set splitbelow

if has('win32')
	set langmenu=en_US
	let $LANG = 'en_US'
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif
set spelllang=ru_yo,en_us,de_de
set mouse=a
set ttymouse=xterm2

" Set backup directory for Windows
if has('win32')
	set backup
	set backupdir=$TEMP
	set backupskip=$TEMP
	set directory=$TEMP
	set undodir=$TEMP
	set writebackup
endif

" Set line numbers and enable syntax highlighting
set number
syntax on

" Tabs, indent and use spaces instead of tabs
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab

" Enable incremental search
set incsearch

" Configure the built-in terminal
set termwinsize=12x0
set splitbelow

"Keyboard mapping
	" reload vimrc 
map <C-r> :source $MYVIMRC<CR>
	" Set F3 for paste unformatted text
set pastetoggle=<F3>
	" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>
let g:AutoPairsShortcutToggle = '<M-p>'

" NERDTree configuration
let NERDTreeShowBookmarks = 1   " Show the bookmarks table
let NERDTreeShowHidden = 1      " Show hidden files
let NERDTreeShowLineNumbers = 0 " Hide line numbers
let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
let NERDTreeWinPos = "left"     " Panel opens on the left side
let NERDTreeWinSize = 31        " Set panel width to 31 columns
nmap <F2> :NERDTreeToggle<CR>

" Tagbar configuration
let g:tagbar_autofocus = 1                  " Focus the panel when opening it
let g:tagbar_autoshowtag = 1                " Highlight the active tag
let g:tagbar_position = 'botright vertical' " Make panel vertical and place on the right
nmap <F8> :TagbarToggle<CR>     

" CTRLSF Configuration
let g:ctrlsf_backend = 'ack' " Use the ack tool as the backend
let g:ctrlsf_auto_close = { "normal":0, "compact":0  } " Auto close the results panel when opening a file
let g:ctrlsf_auto_focus = { "at":"start"  } " Immediately switch focus to the search window 
let g:ctrlsf_auto_preview = 0 " Don't open the preview window automatically
let g:ctrlsf_case_sensitive = 'smart' " Use the smart case sensitivity search scheme
let g:ctrlsf_default_view = 'normal' " Normal mode, not compact mode
let g:ctrlsf_regex_pattern = 0 " Use absoulte search by default
let g:ctrlsf_position = 'right' " Position of the search window 
let g:ctrlsf_winsize = '46' " Width or height of search window
let g:ctrlsf_default_root = 'cwd' " Search from the current working directory

" (Ctrl+F) Open search prompt (Normal Mode)
nmap <C-F>f <Plug>CtrlSFPrompt 
" (Ctrl-F + f) Open search prompt with selection (Visual Mode)
xmap <C-F>f <Plug>CtrlSFVwordPath
" (Ctrl-F + F) Perform search with selection (Visual Mode)
xmap <C-F>F <Plug>CtrlSFVwordExec
" (Ctrl-F + n) Open search prompt with current word (Normal Mode)
nmap <C-F>n <Plug>CtrlSFCwordPath
" (Ctrl-F + o )Open CtrlSF window (Normal Mode)
nnoremap <C-F>o :CtrlSFOpen<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
nnoremap <C-F>t :CtrlSFToggle<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" FSwitch configuration
" These lines specify that:
" When the loaded buffer is a .cpp file, the companion is of type hpp or h.
" When the loaded buffer is a .h file, the companion is of type cpp or c.
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h'
au! BufEnter *.h let b:fswitchdst = 'cpp,c'
nmap <C-Z> :vsplit <bar> :wincmd l <bar> :FSRight<CR>

" Protodef configuration
" The leader key is in fact the backward slash (\) key — meaning that your prototypes will be copied into your implementation file by pressing the \ + PP or \ + PN key combinations. Feel free to adjust these values and consult the documentation for more configuration options by running :help protodef.
    " Pull in prototypes
nmap <buffer> <silent> <leader> ,PP
    " Pull in prototypes without namespace definition"
nmap <buffer> <silent> <leader> ,PN

" YouCompleteMe configuration
" Mapping to close the completion menu (default <C-y>)
let g:ycm_key_list_stop_completion = ['<C-x>']

" Set filetypes where YCM will be turned on
let g:ycm_filetype_whitelist = { 'cpp':1, 'h':2, 'hpp':3, 'c':4, 'cxx':5 }

" Close preview window after completing the insertion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_confirm_extra_conf = 0                 " Don't confirm python conf
let g:ycm_always_populate_location_list = 1      " Always populae diagnostics list
let g:ycm_enable_diagnostic_signs = 1            " Enable line highligting diagnostics
let g:ycm_open_loclist_on_ycm_diags = 1          " Open location list to view diagnostics

let g:ycm_max_num_candidates = 20                " Max number of completion suggestions 
let g:ycm_max_num_identifier_candidates = 10     " Max number of identifier-based suggestions
let g:ycm_auto_trigger = 1                       " Enable completion menu
let g:ycm_show_diagnostic_ui = 1                 " Show diagnostic display features
let g:ycm_error_symbol = '>>'                    " The error symbol in Vim gutter
let g:ycm_enable_diagnostic_signs = 1            " Display icons in Vim's gutter, error, warnings
let g:ycm_enable_diagnostic_highlighting = 1     " Highlight regions of diagnostic text
let g:ycm_echo_current_diagnostic = 1            " Echo line's diagnostic that cursor is on

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
