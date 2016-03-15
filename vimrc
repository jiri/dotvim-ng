" Basics {
  set nocompatible
  set encoding=utf-8
"}

" Plugins {
  call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-commentary'
  Plug 'bling/vim-airline'
  Plug 'godlygeek/tabular'

  " Colors & fonts {
    Plug 'chriskempson/base16-vim'
    Plug 'chriskempson/vim-tomorrow-theme'
    Plug 'sickill/vim-monokai'
  " }

  " Snippets & Completion {
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'

    Plug 'Shougo/neocomplete.vim'
  " }

  " Haskell {
    Plug 'dag/vim2hs', { 'for': [ 'haskell' ] }
    Plug 'eagletmt/neco-ghc', { 'for': [ 'haskell' ] }
  " }

  " LaTeX {
    Plug 'LaTeX-Box-Team/LaTeX-Box'
  " }

  " OpenSCAD {
    Plug 'sirtaj/vim-openscad'
  " }

  " Rust {
    Plug 'rust-lang/rust.vim'
    Plug 'cespare/vim-toml'
  " }

  " Web & SQL {
    Plug 'othree/html5.vim'
    Plug 'exu/pgsql.vim'
  " }

  call plug#end()
" }

" Behavior {
  set autoread
  set hidden
  set fileformats+=mac

  set sessionoptions-=options
  set shell=bash\ --norc

  " Search {
    set incsearch
    set ignorecase smartcase
    set nohlsearch
  " }

  " Backups {
    set nobackup
    set noswapfile
  " }

  " Disable beeping {
    set noerrorbells
    set vb t_vb=  
  " }

  " Persistent undo {
    if has("persistent_undo")
      silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
      set undodir=~/.vim/undo
      set undofile
    endif
  " }
" }

" Keyboard {
  noremap ; :
  noremap Q <nop>

  " Supreme leader
  let mapleader = "\<space>"
  let maplocalleader = "\<space>"

  " Line bubbling & indentation {
    vnoremap <silent> K :move '<-2<CR>gv=gv
    vnoremap <silent> J :move '>+1<CR>gv=gv

    vnoremap H <gv
    vnoremap L >gv
  " }

  " Buffer switching {
    nmap <silent> <leader>] :bn<CR>
    nmap <silent> <leader>[ :bp<CR>
  " }

  " Miscellaneous {
    nmap <silent> <leader>o :!open %<CR><CR>
  " }
"}

" Text {
  " Colors & fonts {
    " http://input.fontbureau.com
    set guifont=Input:h14

    " http://chriskempson.github.io/base16/#eighties
    " set background=dark
    colorscheme monokai

    if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
      set t_Co=16
    endif
  " }

  " Indentation {
    filetype plugin indent on
    set smartindent
    set ts=2 sts=2 sw=2 expandtab
  " }

  " Tweaks {
    " Remove comment delimiter when joining commented lines
    set formatoptions+=j
  " }
" }

" UI {
  set lines=24
  set columns=80

  set number
  set nowrap
  set wildmenu

  " GUI {
    if has("gui_running")
      set guioptions=c
    endif
  " }
" }

" Vimrc reloading {
  augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd BufWritePost $MYVIMRC AirlineRefresh
  augroup END

  autocmd FileType vim setlocal keywordprg=:help
" }

" Airline {
  set laststatus=2
  set noshowmode

  let g:airline_powerline_fonts = 1

  " Enable tabline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#fnamemod = ':t'
" }

" Commentary {
  noremap <leader>c :Commentary<CR>
" }

" Haskell {
  let g:haskellmode_completion_ghc = 0
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

  " Ensure ghc-mod is in $PATH
  let $PATH = $PATH . ':' . expand("~/.local/bin")
" }

" NeoComplete {
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1

  imap <expr><CR> pumvisible() ?
        \ (neosnippet#expandable() ?
        \   "\<Plug>(neosnippet_expand_or_jump)" :
        \   "\<C-y>")
        \ : "\<CR>"
  inoremap <expr><s-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
  inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"
" }

" NeoSnippet {
  let g:neosnippet#snippets_directory = '~/.vim/plugged/vim-snippets/snippets'
" }

" LaTeX-Box {
  " autocmd FileType tex setlocal wrap lbr
  autocmd FileType tex noremap <buffer> <silent> k gk
  autocmd FileType tex noremap <buffer> <silent> j gj

  let g:LatexBox_Folding = 1
  let g:LatexBox_viewer = "texshop-preview"

  " Mappings {
    function! g:ToggleConceal()
      if(&conceallevel)
        setlocal conceallevel=0
      else
        setlocal conceallevel=2
      endif
    endfunc

    autocmd FileType tex vmap <buffer> <localleader>lw <Plug>LatexWrapSelection
    autocmd FileType tex nmap <buffer> § :call ToggleConceal()<CR>
  " }
" }

" Netrw {
  let g:netrw_silent = 1
" }
