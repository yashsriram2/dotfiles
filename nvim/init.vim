set nocompatible

let mapleader=" "

call plug#begin()
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'vim-airline/vim-airline'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'lifepillar/vim-mucomplete'
  Plug 'airblade/vim-gitgutter'
  Plug 'sirver/ultisnips'
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'yashsriram/vim-searchindex'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

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
  set number relativenumber
  set splitbelow splitright
  set encoding=utf-8
  set tabstop=4 shiftwidth=4 expandtab
  set listchars=tab:→\ ,trail:•,nbsp:‡,extends:⟩,precedes:⟨ list
  set noswapfile
  set autoread
  set hidden
  set scrolloff=999

" spelling
  nnoremap <C-l> 1z=

" appearance
  colorscheme PaperColor
  set background=dark
  highlight Visual ctermfg=NONE
  highlight Visual ctermbg=237
  highlight Normal ctermbg=black
  " let g:airline_theme='dark'
  set cursorline

" highlevel
  nnoremap ; :
  nnoremap <C-h> :vertical help<Space>
  nnoremap <C-A-h> "hyiw:vertical help <C-r>h<Enter>
  nnoremap <Enter> O<Esc>j

" basic navigation
  nnoremap <Up> gk
  nnoremap <Down> gj
  nnoremap <C-b> %

" selection
  vnoremap > >gv
  vnoremap < <gv
  nnoremap <S-Up> Vk
  nnoremap <S-Down> Vj
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

" make sure vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \     execute 'normal! g`"zvzz' |
      \ endif
augroup END

" copy to system clipboard
  vnoremap <C-y> "+y
  nnoremap yall ggVG"+y

" find
  set nowrapscan
  nnoremap <A-f> :set hlsearch!<Enter>
  nnoremap <A-c> :set ignorecase!<Enter>
  nnoremap <C-A-f> *N
  vnoremap / "fy/<C-r>f<Enter>

" replace
  nnoremap <C-r> :%s///gc<Left><Left><Left><Left>
  nnoremap <C-A-r> viw"ry:%s/<C-r>r/<C-r>r/gc<Left><Left><Left>
  vnoremap <C-r> "ry:%s/<C-r>r//gc<Left><Left><Left>

" remove all trailing whitespace
  nnoremap gws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><Enter>

" convert b/w tabs and spaces
  nnoremap gts :set tabstop=2 shiftwidth=2 expandtab<Bar>:retab<Enter>
  nnoremap gtt :set tabstop=2 shiftwidth=2 noexpandtab<Bar>:%retab!<Enter>

" reformat the entire file
  nnoremap grf magg=G`a

" command mode
  cnoremap <C-a> <home>
  cnoremap <C-e> <end>

" buffers
  nnoremap qq :bd<Enter>
  nnoremap <A-Left> :bp<Enter>
  nnoremap <A-Right> :bn<Enter>

" tabs
  nnoremap qQ :q<Enter>
  nnoremap <C-t> :enew<Enter>
  nnoremap <A-Up> :tabp<Enter>
  nnoremap <A-Down> :tabn<Enter>
  nnoremap <A-h> :sp<Enter>
  nnoremap <A-v> :vsp<Enter>

" panes/windows
  nnoremap <A-S-Down> <C-w>j
  nnoremap <A-S-Up> <C-w>k
  nnoremap <A-S-Left> <C-w>h
  nnoremap <A-S-Right> <C-w>l

" folding
  set foldlevel=99
  set foldmethod=syntax
  nnoremap <Tab> za

" tags
  nnoremap <leader><Right> <C-]>
  nnoremap <leader><Left> <C-t>

" jumps
  nnoremap <leader><Up> <C-I>
  nnoremap <leader><Down> <C-O>

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
let g:LanguageClient_serverCommands = {
    \ 'rust'    : ['~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rust-analyzer'],
    \ 'python'  : ['~/.local/bin/pyls'],
    \ 'c'       : ['clangd-10'],
    \ 'cpp'     : ['clangd-10'],
    \ }
nnoremap <leader>l :call LanguageClient_contextMenu()<Enter>
autocmd BufWritePost *.rs,*.py,*.c,*.cpp call LanguageClient#textDocument_formatting()
nnoremap <leader>n :call LanguageClient#textDocument_rename()<Enter>
nnoremap <leader>d :call LanguageClient#textDocument_definition()<Enter>
nnoremap <leader>h :call LanguageClient#textDocument_hover()<Enter>
nnoremap <leader>r :call LanguageClient#textDocument_references()<Enter>
nnoremap <leader>i :call LanguageClient#textDocument_implementation()<Enter>
nnoremap <leader>g :GFiles<Enter>

" airline
  let g:airline#extensions#tabline#enabled = 1
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

" smart spell check
  autocmd BufReadPost,BufNewFile *.tex setlocal spell | set spelllang=en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" set html syntax for tera templates
  autocmd BufReadPost *.html.tera set syntax=html
