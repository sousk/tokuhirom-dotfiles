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

    filetype plugin on

" -------------------------------------------------------------------------
" perl
"
" -------------------------------------------------------------------------
    inoremap ,self <C-R> my ($self, ) = @_;<CR>
    iabbrev ,# # =========================================================================
    iabbrev .# # -------------------------------------------------------------------------

    scriptencoding utf-8
    
    function! s:get_package_name()
        let mx = '^\s*package\s\+\([^ ;]\+\)'
        for line in getline(1, 5)
            if line =~ mx
            return substitute(matchstr(line, mx), mx, '\1', '')
            endif
        endfor
        return ""
    endfunction
    
    function! s:check_package_name()
        let path = substitute(expand('%:p'), '\\', '/', 'g')
        let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
        if path[-len(name):] != name
            echohl WarningMsg
            echomsg "ぱっけーじめいと、ほぞんされているぱすが、ちがうきがします！"
            echomsg "ちゃんとなおしてください＞＜"
            echohl None
        endif
    endfunction
    
    au! BufWritePost *.pm call s:check_package_name()
 
" -------------------------------------------------------------------------
" perl test
"
" -------------------------------------------------------------------------
    augroup filetypedetect
    autocmd! BufNewFile,BufRead *.t setf perl
    autocmd! BufNewFile,BufRead *.psgi setf perl
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

" -------------------------------------------------------------------------
" neocomplcache
" -------------------------------------------------------------------------
    " Use neocomplcache.
    let g:NeoComplCache_EnableAtStartup = 1
    " Use smartcase.
    let g:NeoComplCache_SmartCase = 1
    " Use camel case completion.
    let g:NeoComplCache_EnableCamelCaseCompletion = 1
    " Use underbar completion.
    let g:NeoComplCache_EnableUnderbarCompletion = 1
    " Set minimum syntax keyword length.
    let g:NeoComplCache_MinSyntaxLength = 3
    " Set manual completion length.
    let g:NeoComplCache_ManualCompletionStartLength = 0

    " Print caching percent in statusline.
    "let g:NeoComplCache_CachingPercentInStatusline = 1

    " Define dictionary.
    let g:NeoComplCache_DictionaryFileTypeLists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions',
                \ 'scala' : $DOTVIM.'/dict/scala.dict',
                \ 'ruby' : $DOTVIM.'/dict/ruby.dict'
                \ }

    " Define keyword.
    if !exists('g:NeoComplCache_KeywordPatterns')
        let g:NeoComplCache_KeywordPatterns = {}
    endif
    let g:NeoComplCache_KeywordPatterns['default'] = '\v\h\w*'

    let g:NeoComplCache_SnippetsDir = $HOME.'/snippets'

