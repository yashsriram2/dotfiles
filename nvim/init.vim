set nocompatible

let mapleader=" "

call plug#begin()
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'vim-airline/vim-airline'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'lifepillar/vim-mucomplete'
  Plug 'airblade/vim-gitgutter'
  Plug 'sirver/ultisnips'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'yashsriram/vim-searchindex'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'peterhoeg/vim-qml'
  Plug 'DingDean/wgsl.vim'

  Plug 'lervag/vimtex'
  Plug 'cespare/vim-toml', {
    \ 'branch': 'main',
    \ }
  Plug 'tikhomirov/vim-glsl'

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

" basic options
  syntax on
  filetype plugin on
  set title
  set mouse=a
  set number
  set splitbelow splitright
  set encoding=utf-8
  set tabstop=4 shiftwidth=4 expandtab
  set listchars=tab:→\ ,trail:•,nbsp:‡,extends:⟩,precedes:⟨ list
  set noswapfile
  set autoread
  set hidden
  set scrolloff=999

" appearance
  colorscheme PaperColor
  set background=dark
  highlight Visual ctermfg=yellow ctermbg=238 cterm=underline
  highlight Normal ctermbg=black
  highlight Folded ctermfg=yellow ctermbg=black cterm=bold
  " let g:airline_theme='dark'
  set cursorline

" highlevel
  nnoremap ; :
  nnoremap <Enter> O<Esc>j

" basic navigation
  nnoremap <Up> gk
  nnoremap <Down> gj
  nnoremap <C-b> %

" selection
  vnoremap > >gv
  vnoremap < <gv
  vnoremap <S-Up> k
  vnoremap <S-Down> j

" common editing shortcuts
  nnoremap <C-z> <nop>
  nnoremap U <C-r>
  nnoremap <C-d> yyp
  nnoremap <C-x> dd
  nnoremap <C-c> yy
  nnoremap <C-v> P
  vnoremap D "_d
  nnoremap Y y$

" save
  nnoremap <C-s> :w<Enter>
  inoremap <C-s> <Esc>:w<Enter>i
  vnoremap <C-s> <Esc>:w<Enter>

" copy to system clipboard
  vnoremap <C-y> "+y
  nnoremap yall ggVG"+y

" find
  set nowrapscan
  nnoremap F     *N:set hlsearch<Enter>
  nnoremap <A-f> :set hlsearch!<Enter>
  nnoremap <C-f>     :Rg!<space>
  nnoremap <C-A-f>   "hyiw:Rg! <C-r>h

" remove all trailing whitespace
  nnoremap gws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><Enter>

" convert b/w tabs and spaces
  nnoremap gts :set tabstop=2 shiftwidth=2 expandtab<Bar>:retab<Enter>
  nnoremap gtt :set tabstop=2 shiftwidth=2 noexpandtab<Bar>:%retab!<Enter>

" command mode
  cnoremap <C-a> <home>
  cnoremap <C-e> <end>

" buffers
  nnoremap qq :bd<Enter>
  nnoremap <A-Left> :bp<Enter>
  nnoremap <A-Right> :bn<Enter>
  nnoremap <C-t> :enew<Enter>

" panes/windows
  nnoremap <A-S-Down> <C-w>j
  nnoremap <A-S-Up> <C-w>k
  nnoremap <A-S-Left> <C-w>h
  nnoremap <A-S-Right> <C-w>l

" folding
  set foldlevel=99
  set foldmethod=syntax
  nnoremap <Tab> za

" ranger
  let g:ranger_replace_netrw = 1

" mucomplete
  set completeopt+=menuone
  set completeopt+=noselect
  set completeopt-=preview
  set shortmess+=c
  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#completion_delay = 3

" ultisnips
  let g:UltiSnipsExpandTrigger="<Tab>"
  let g:UltiSnipsJumpForwardTrigger="<Tab>"
  let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" lsp client
nnoremap <leader>l :call LanguageClient_contextMenu()<Enter>

let g:LanguageClient_serverCommands = {
    \ 'rust'    : ['~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer'],
    \ 'c'       : ['clangd-10'],
    \ 'cpp'     : ['clangd-10'],
    \ }
nnoremap <C-Right> <C-I>
nnoremap <C-Left> <C-O>
nnoremap gd :call LanguageClient#textDocument_definition()<Enter>
nnoremap gi :call LanguageClient#textDocument_implementation()<Enter>
nnoremap gr :call LanguageClient#textDocument_references()<Enter>
nnoremap gh :call LanguageClient#textDocument_hover()<Enter>
nnoremap gt :call LanguageClient#textDocument_formatting()<Enter>
nnoremap ga :call LanguageClient#textDocument_codeAction()<Enter>
nnoremap gn :call LanguageClient#textDocument_rename()<Enter>

" airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#hunks#enabled=0
  let g:airline#extensions#branch#enabled = 0
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline_powerline_fonts = 1
  if !exists('g:airline_symbols')
      let g:airline_symbols = {}
  endif

" vimtex
  let g:tex_flavor='latex'
  let g:vimtex_quickfix_mode=0

" auto commands
  augroup vimrc
    " make sure vim returns to the same line when you reopen a file.
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
    autocmd!
    autocmd BufReadPost *.py normal zM
    autocmd BufReadPost *.py set foldmethod=indent
    autocmd CursorMoved *.py :call LanguageClient#textDocument_documentHighlight()
    autocmd BufWritePost *.rs :call LanguageClient#textDocument_formatting()
  augroup END
