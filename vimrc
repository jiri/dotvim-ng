" Basics {
  set nocompatible
  set encoding=utf-8
"}

" Plugins {
  call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-commentary'
  Plug 'bling/vim-airline'

  " Colors & fonts {
    Plug 'chriskempson/base16-vim'
    Plug 'chriskempson/vim-tomorrow-theme'
  " }

  " Completion {
    " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
    " Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

    Plug 'Shougo/neocomplete.vim'
  " }

  " Snippets {
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'
  " }

  " Haskell {
    Plug 'dag/vim2hs', { 'for': [ 'haskell' ] }
    " Plug 'eagletmt/neco-ghc', { 'for': [ 'haskell' ] }
  " }

  " LaTeX {
    Plug 'LaTeX-Box-Team/LaTeX-Box'
  " }

  call plug#end()
" }

" Behavior {
  set autoread
  set hidden
  set fileformats+=mac

  set sessionoptions-=options

  " Search {
    set incsearch
    set smartcase
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
  let mapleader = "\<space>"
  let maplocalleader = "\<space>"

  noremap ; :
  noremap Q <nop>

  " Line bubbling & indentation {
    vnoremap <silent> K :move '<-2<CR>gv=gv
    vnoremap <silent> J :move '>+1<CR>gv=gv

    vnoremap H <gv
    vnoremap L >gv
  " }

  " Buffer switching {
    nmap <leader>] :bn<CR>
    nmap <leader>[ :bp<CR>
  " }
"}

" Text {
  " Colors & fonts {
    set guifont=Input:h16

    set background=dark
    colorscheme base16-eighties

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

  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline#extensions#tabline#fnamemod = ':t'
" }

" Commentary {
  noremap <leader>c :Commentary<CR>
" }

" Haskell {
  " let g:haskellmode_completion_ghc = 0
  " autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

  " Ensure ghc-mod is in $PATH
  " let $PATH = $PATH . ':' . expand("~/.local/bin")
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

  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
" }

" LaTeX-Box {
  autocmd FileType tex set wrap lbr
  autocmd FileType tex noremap <buffer> <silent> k gk
  autocmd FileType tex noremap <buffer> <silent> j gj

  let g:LatexBox_Folding = 1
  let g:LatexBox_viewer = "texshop-preview"

  " Mappings {
    vmap <buffer> <localleader>lw <Plug>LatexWrapSelection
  " }
" }

" Netrw {
  let g:netrw_silent = 1
" }
