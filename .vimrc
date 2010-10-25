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
" tabs
" -------------------------------------------------------------------------
    nnoremap <Space>t t
    nnoremap <Space>T T
    nnoremap t <Nop>
    nnoremap <silent> tc :<C-u>tabnew<CR>:tabmove<CR>
    nnoremap <silent> tk :<C-u>tabclose<CR>
    nnoremap <silent> tn :<C-u>tabnext<CR>
    nnoremap <silent> tp :<C-u>tabprevious<CR>
    nnoremap <silent> bn :<C-u>bnext<CR>
    nnoremap <silent> bp :<C-u>bprevious<>
    nnoremap <silent> bd :<C-u>bdelete<CR>
    nnoremap <silent> gd :<C-u>bdelete<CR>
    nnoremap <silent> gn :<C-u>bnext<CR>
    nnoremap <silent> gp :<C-u>bprevious<CR>
    for n in range(1,9) | exe "nnoremap <silent> g".n." :buffer ".n."<cr>" | endfor

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
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
	" Use camel case completion.
	let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	let g:neocomplcache_enable_underbar_completion = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
	
	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : '',
	    \ 'vimshell' : $HOME.'/.vimshell_hist',
	    \ 'scheme' : $HOME.'/.gosh_completions'
	        \ }
		
	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
	    let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
	
	" Plugin key-mappings.
	imap <C-k>     <Plug>(neocomplcache_snippets_expand)
	smap <C-k>     <Plug>(neocomplcache_snippets_expand)
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()
	
	" SuperTab like snippets behavior.
	"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
	
	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
	
	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1
	
	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
	"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
	
	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	
	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
		let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
	"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" -------------------------------------------------------------------------
" minibufexpl
" -------------------------------------------------------------------------
    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 1
    let g:miniBufExplMapCTabSwitchBuffs = 1

" -------------------------------------------------------------------------
" package name validation for perl
" -------------------------------------------------------------------------

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
" pathogen
" 
" see http://subtech.g.hatena.ne.jp/secondlife/20101012/1286886237
" -------------------------------------------------------------------------
    call pathogen#runtime_append_all_bundles()

" -------------------------------------------------------------------------
" fuf.vim
" -------------------------------------------------------------------------
"   let g:fuf_modesDisable = ['mrucmd']
"   let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
"   let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
"   let g:fuf_mrufile_maxItem = 10000
"   let g:fuf_enumeratingLimit = 20
"   let g:fuf_keyPreview = '<C-]>'
"   let g:fuf_previewHeight = 0

"   nmap bg :FufBuffer<CR>
"   nmap bG :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
"   nmap gb :FufFile **/<CR>
"   nmap br :FufMruFile<CR>
"   nmap bq :FufQuickfix<CR>
"   nmap bl :FufLine<CR>
"   nnoremap <silent> <C-]> :FufTag! <C-r>=expand('<cword>')<CR><CR> 

" -------------------------------------------------------------------------
"  unite.vim
" -------------------------------------------------------------------------
   let g:unite_enable_start_insert = 1
   nmap bg :Unite -buffer-name=files buffer_tab file_mru file bookmark<CR>

