" *************************************************************************
" tokuhirom's .vimrc file.
"
" *************************************************************************

" -------------------------------------------------------------------------
" Basic settings.
"
" -------------------------------------------------------------------------
    set nocompatible " must be first!

    colorscheme darkblue

    nnoremap j gj
    nnoremap k gk

    set expandtab
    set shiftround
    set autoindent
    set backspace=indent,eol,start
    set hidden
    set history=50
    set hlsearch
    set ignorecase
    set incsearch
    set laststatus=2
    set nobackup
    set ruler
    set shiftwidth=4
    set showcmd
    set showmatch
    set smartcase
    set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
    set tabstop=4
    set wrapscan
    syntax on
    autocmd CursorHold * update
    set updatetime=500
    set encoding=utf-8
    set fileencoding=utf-8
    set fileencodings=utf-8,euc-jp,iso-2022-jp,utf-8,cp932 
    set ambw=double

" -------------------------------------------------------------------------
" perl
"
" -------------------------------------------------------------------------
    inoremap ,self <C-R> my ($self, ) = @_;<CR>
    iabbrev ,# # =========================================================================
    iabbrev .# # -------------------------------------------------------------------------

" -------------------------------------------------------------------------
" perl test
"
" -------------------------------------------------------------------------
    augroup filetypedetect
    autocmd! BufNewFile,BufRead *.t setf perl
    augroup END

" -------------------------------------------------------------------
" auto cd.
"    ref. http://nanasi.jp/articles/vim/cd_vim.html
"
" -------------------------------------------------------------------------
    au BufEnter * execute ":lcd " . expand("%:p:h") 

" -------------------------------------------------------------------------
" ChangeLog
"
" -------------------------------------------------------------------------
    let g:changelog_username = 'tokuhirom <tokuhirom atooooo gmail dototettetetete com>'

" -------------------------------------------------------------------------
" matchit
"    ref. http://nanasi.jp/articles/vim/matchit_vim.html
"
" -------------------------------------------------------------------------
    source $VIMRUNTIME/macros/matchit.vim

" actionscript
    autocmd BufRead *.as set filetype=javascript

" -------------------------------------------------------------------------
" perltidy
" -------------------------------------------------------------------------
    map ,pt <Esc>:%! perltidy<CR>
    map ,ptv <Esc>:'<,'>! perltidy<CR>

