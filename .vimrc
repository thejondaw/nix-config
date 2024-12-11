" === Vim-Plug Plugin Manager === "
call plug#begin()

" === Appearance === "
" Catppuccin theme
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" File tree
Plug 'preservim/nerdtree'

" === Language Support === "
" Nix support
Plug 'LnL7/vim-nix'

" === Functionality === "
" File search
Plug 'ctrlpvim/ctrlp.vim'
" Auto pairs for brackets
Plug 'jiangmiao/auto-pairs'
" Easy commenting
Plug 'tpope/vim-commentary'
" Indent guides
Plug 'Yggdroot/indentLine'

call plug#end()

" === General Settings === "
syntax on
set encoding=UTF-8
set number
set ruler
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set ignorecase
set smartcase
set showmatch
set mouse=a
set termguicolors
set hidden
set nobackup
set noswapfile
set scrolloff=8
set signcolumn=yes
set updatetime=300
set timeoutlen=500
set clipboard=unnamedplus
set noshowmode

" === Theme Settings === "
colorscheme catppuccin_mocha
let g:airline_theme='catppuccin_mocha'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" === Plugin Settings === "
" NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" CtrlP
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

" IndentLine
let g:indentLine_char = '┊'
let g:indentLine_first_char = '┊'
let g:indentLine_showFirstIndentLevel = 1

" === Keyboard Mappings === "
" Leader key
let mapleader = " "

" NERDTree
map <F3> :NERDTreeToggle<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" Clear search highlighting
nnoremap <esc> :noh<return><esc>

" Russian keyboard layout support
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" === Auto Commands === "
" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Format on save
autocmd BufWritePre * %s/\s\+$//e

" === Status Line === "
set laststatus=2
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
let g:airline_section_z = '%l:%c'
