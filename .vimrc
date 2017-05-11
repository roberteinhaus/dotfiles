" Install Vundle.vim
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" set the runtime path to include Vundle and initialize
if has("win32") || has("win32")
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$HOME/vimfiles/bundle/')
    if has("gui_running")
        " GUI is running or is about to start.
        " Maximize gvim window (for an alternative on Windows, see simalt below).
        set lines=999 columns=999
        set guifont=DejaVuSansMonoForPowerline_NF:h11
    else
        " This is console Vim.
        if exists("+lines")
            set lines=50
        endif
        if exists("+columns")
            set columns=100
        endif
    endif
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'python-mode/python-mode'
Plugin 'tpope/vim-fugitive'

Plugin 'henrik/vim-indexed-search'

Plugin 'jakedouglas/exuberant-ctags'
Plugin 'majutsushi/tagbar'

Plugin 'raimondi/delimitmate'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'matze/vim-move'

Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

Plugin 'morhetz/gruvbox'
Plugin 'ryanoasis/vim-devicons'

Plugin 'christoomey/vim-tmux-navigator'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""
"  General  "
"""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
" Prevent redraw for macros
set lazyredraw

" Reduce timeout after <ESC> is recieved.
set timeout
set ttimeoutlen=50

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"

set undofile
set undodir=~/.vim/undodir

""""""""
"  UI  "
""""""""
set relativenumber
nmap <F9> :set invrelativenumber<CR>
set pastetoggle=<F12>
set cursorline

" Avoid garbled characters in Chinese language windows OS
let $LANG='de'
set langmenu=de
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=2
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" More intuitive split placement
set splitbelow
set splitright


""""""""""""""""""""""
"  Colors and Fonts  "
""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
set t_Co=256

try
	"let g:solarized_termcolors=256
	"colorscheme solarized
    colorscheme gruvbox
    let g:gruvbox_contrast_dark="hard"
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right scrollbar
    set guioptions-=L  "remove left scrollbar
    set guioptions-=b  "remove bottom scrollbar
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""
"  Backups  "
"""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


""""""""""""""""""""""""""""""""""
"  Text, tab and indent related  "
""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Auto indent
set autoindent
" Smart indent
set smartindent

" Wrap lines
set wrap


"""""""""""""""""""""""""""
"  Moving around windows  "
"""""""""""""""""""""""""""
" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""
"  Status line  "
"""""""""""""""""
" Always show the status line
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Needed to get ALT-Key working
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw


""""""""""""""
"  NERDTree  "
""""""""""""""
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>


""""""""""""
"  PyMode  "
""""""""""""
let g:pymode_folding = 1
set foldlevelstart=99
nnoremap - za
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
let g:pymode_rope_autoimport_import_after_complete = 1


"""""""""""""""
"  Ultisnips  "
"""""""""""""""
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:snips_author="Robert Einhaus"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1

""""""""""""""
"  Mappings  "
""""""""""""""
cmap w!! w !sudo tee % >/dev/null
nmap ü :put +<CR>
map <C-m> :TagbarToggle<CR>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

vnoremap <Leader>r y<ESC>:%s/<C-r>"//g<left><left>
