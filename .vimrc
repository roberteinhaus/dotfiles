" Install Vundle.vim
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" set the runtime path to include Vundle and initialize
if has("win32") || has("win32")
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
endif

call plug#begin('~/.vim/bundle')
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'

Plug 'python-mode/python-mode'
Plug 'fatih/vim-go'
Plug 'ternjs/tern_for_vim'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'burnettk/vim-angular'

Plug 'henrik/vim-indexed-search'

Plug 'jakedouglas/exuberant-ctags'
Plug 'majutsushi/tagbar'

Plug 'raimondi/delimitmate'
Plug 'tpope/vim-surround'
Plug 'bronson/vim-trailing-whitespace'
Plug 'matze/vim-move'

Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

Plug 'vimwiki/vimwiki'

Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'altercation/vim-colors-solarized'

Plug 'christoomey/vim-tmux-navigator'

" All of your Plugs must be added before the following line
call plug#end()


"""""""""""""
"  General  "
"""""""""""""
" Make global replace the default option
set gdefault

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
" Prevent redraw for macros
set lazyredraw

" Reduce timeout after <ESC> is received.
set timeout
set ttimeoutlen=50

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"

set undofile
set undodir=~/.vim/undodir

" Spellchecking
set spell spelllang=de_de,en
set nospell
" Toggle spellchecking
nnoremap <silent> <Leader>s :setlocal spell!<CR>
map <Leader>d ]s
map <Leader>a [s
" Enable spell checking for markdown files
augroup enable_spell
    autocmd!
    au BufRead *.md setlocal spell
    au BufRead *.markdown setlocal spell
augroup END

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
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
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=2
set whichwrap+=<,>,h,l

" Ignore case when searching
set infercase

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

set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

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
augroup edit_position
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END


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
augroup nerdtree
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END
map <C-n> :NERDTreeToggle<CR>


""""""""""""
"  PyMode  "
""""""""""""
let g:pymode_folding = 1
set foldlevelstart=99
nnoremap - za
let g:pymode_rope_autoimport = 0
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
let g:pymode_rope_autoimport_import_after_complete = 0
let g:pymode_rope = 0


"""""""""""""""
"  Ultisnips  "
"""""""""""""""
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:snips_author="Robert Einhaus"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""
"  YouCompleteMe  "
"""""""""""""""""""
" omnifuncs
augroup omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_show_signature_in_pum = 1
    autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

let g:tsuquyomi_use_local_typescript = 0
let g:tsuquyomi_use_dev_node_module = 0

if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif

let g:ycm_semantic_triggers =  {
            \   'c' : ['->', '.'],
            \   'objc' : ['->', '.'],
            \   'ocaml' : ['.', '#'],
            \   'cpp,objcpp' : ['->', '.', '::'],
            \   'perl' : ['->'],
            \   'php' : ['->', '::', '"', "'", 'use ', 'namespace ', '\'],
            \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
            \   'html': ['<', '"', '</', ' '],
            \   'vim' : ['re![_a-za-z]+[_\w]*\.'],
            \   'ruby' : ['.', '::'],
            \   'lua' : ['.', ':'],
            \   'erlang' : [':'],
            \   'haskell' : ['.', 're!.']
            \ }

"""""""""""
"  CtrlP  "
"""""""""""
" Setup some default ignores
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'


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

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

vnoremap <Leader>r y<ESC>:%s/<C-r>"//g<left><left>

noremap <F3> :GoDef<CR>
