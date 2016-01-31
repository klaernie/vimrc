set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-scriptease'
Plugin 'godlygeek/tabular'
Plugin 'gregsexton/MatchTag'
Plugin 'powerman/vim-plugin-AnsiEsc'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'chrisbra/csv.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-php/tagbar-phpctags.vim'
Plugin 'EinfachToll/DidYouMean'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set background=dark
set modeline
"set mouse=a
set title
if exists("&tabpagemax")
    set tabpagemax=100
endif

" vim-airline-related
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1

filetype plugin indent on
set autoindent
set smartindent
set hlsearch
nohlsearch

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'js',
    \ 'kinds' : [
        \ 'r:global variables:0:0',
        \ 'o:objects:0:0',
        \ 'a:arrays:0:0',
        \ 'f:functions',
        \ 'c:callbacks',
    \ ],
    \ 'kind2scope' : {
        \ 'callback' : 'f',
    \ },
\ }

" make :set list more useful
set list listchars:tab:▸\ ,eol:¬,trail:▇,nbsp:·

" allow me to backspace anything
set backspace=indent,eol,start

if has("gui_running")
	set guifont=Terminus
endif

" source my aux vimscripts
runtime keymappings.vimrc
if v:version >= 700
	runtime muttaliasescomplete.vim
endif

" include man-ftplugin to get :Man
runtime ftplugin/man.vim

command! -nargs=1 -complete=help H :tab help <args> |
			\let helpfile = expand("%") |
			\execute "tab view ".helpfile

if v:version >= 700
	colorscheme zenburn
else
	colorscheme desert
endif


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
 au!
 autocmd BufReadPost *
 \ if expand("<afile>:p:h") !=? $TEMP |
 \ if line("'\"") > 1 && line("'\"") <= line("$") |
 \ let JumpCursorOnEdit_foo = line("'\"") |
 \ let b:doopenfold = 1 |
 \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
 \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
 \ let b:doopenfold = 2 |
 \ endif |
 \ exe JumpCursorOnEdit_foo |
 \ endif |
 \ endif
 " Need to postpone using "zv" until after reading the modelines.
 autocmd BufWinEnter *
 \ if exists("b:doopenfold") |
 \ exe "normal zv" |
 \ if(b:doopenfold > 1) |
 \ exe "+".1 |
 \ endif |
 \ unlet b:doopenfold |
 \ endif
augroup END

