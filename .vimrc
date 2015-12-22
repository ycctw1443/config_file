set clipboard=unnamed

set shiftround
set infercase
set showmatch
set matchtime=3

set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start

set nowritebackup
set nobackup
set noswapfile

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
set number
set wrap
set textwidth=0
autocmd FileType python setl colorcolumn=80

set ignorecase
set smartcase
set incsearch
set hlsearch

inoremap jj <Esc>
nnoremap j gj
nnoremap k gk
vnoremap v $h

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4


"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:

" neocompleteの設定
if has('lua') && v:version >= 703 && has('patch885')
    NeoBundleLazy "Shougo/neocomplete.vim", {
        \ "autoload": {
        \   "insert": 1,
        \ }}
    " 2013-07-03 14:30 NeoComplCacheに合わせた
    let g:neocomplete#enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplet#enable_smart_case = 1
        " NeoCompleteを有効化
        " NeoCompleteEnable
    endfunction
endif
set completeopt=menuone

" neosnippetの設定
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neosnippet'
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"""inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
"""imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"""smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ?
"\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"""imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ?
"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"""smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
"""if has('conceal')
"""  set conceallevel=2 concealcursor=i
"""  endif



NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

NeoBundle 'Shougo/Unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
"バッファを閉じないようにする
let g:unite_split_rule = 'botright'
noremap ,u <ESC>:Unite -vertical -winwidth=30 -no-quit outline<Return>


NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'gmake -f make_unix.mak',
      \    },
      \ }
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config = {'*': {'split': ''}}
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }
let g:quickrun_no_default_key_mappings = 1
nnoremap /r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap /r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
au FileType qf nnoremap <silent><buffer>q :quit<CR>

NeoBundle 'kana/vim-smartinput'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-replace.git'
map _ <Plug>(operator-replace)
NeoBundle 'rhysd/vim-operator-surround'
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)


NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle "thinca/vim-template"

" vimfiler設定
NeoBundle "Shougo/vimfiler"
"Use vimfiler instead of default filer.
let g:vimfiler_as_default_explorer = 1
autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
" Open filer
noremap <silent> :tree :VimFiler -split -simple -winwidth=30 -no-quit
noremap <C-X><C-T> :VimFiler -split -simple -winwidth=30 -no-quit<ENTER>
" Don't let <CR> enter the directory but let it open the directory
autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
" Automatically open vimfiler on start
"autocmd VimEnter * VimFilerExplorer
" If no files are specified, open vimfiler
"autocmd VimEnter * if !argc() | VimFiler | endif


NeoBundle "scrooloose/syntastic", {
      \ "build": {
      \ "mac": ["pip install flake8","npm -g install coffeelint"],
      \ "unix": ["pip install flake8","npm -g install coffeelint"],
      \ }}
let g:syntastic_python_checkers = ["flake8"]
" python設定
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
    \ "autoload": {"insert": 1, "filetypes": ["python", "python3", "djangohtml"]}}

NeoBundleLazy "nvie/vim-flake8", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

NeoBundleLazy "davidhalter/jedi-vim", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"],
      \ },
      \ "build": {
      \   "mac": "pip install jedi",
      \   "unix": "pip install jedi",
      \ }}


NeoBundle "kana/vim-textobj-indent"
NeoBundle "bps/vim-textobj-python"
NeoBundle "jmcantrell/vim-virtualenv"
let g:virtualenv_directory = '~'


autocmd BufWinEnter  *.py PyHlLVar
autocmd BufWinLeave  *.py PyHlLVar
autocmd WinEnter     *.py PyHlLVar
autocmd BufWritePost *.py PyHlLVar
autocmd WinLeave     *.py PyHlLVar
autocmd TabEnter     *.py PyHlLVar
autocmd TabLeave     *.py PyHlLVar



" Gitの設定
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'cohama/agit.vim'
NeoBundle 'idanarye/vim-merginal'
NeoBundle 'rhysd/committia.vim'

" Markdownの設定
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

"オートセーブの設定
NeoBundle 'vim-scripts/vim-auto-save'
" デフォルトで有効にする
autocmd FileType markdown let g:auto_save = 1

"色設定
" solarized カラースキーム
  NeoBundle 'altercation/vim-colors-solarized'
" mustang カラースキーム
  NeoBundle 'croaker/mustang-vim'
" wombat カラースキーム
  NeoBundle 'jeffreyiacono/vim-colors-wombat'
" jellybeans カラースキーム
  NeoBundle 'nanotech/jellybeans.vim'
" lucius カラースキーム
  NeoBundle 'vim-scripts/Lucius'
" zenburn カラースキーム
  NeoBundle 'vim-scripts/Zenburn'
" mrkn256 カラースキーム
  NeoBundle 'mrkn/mrkn256.vim'
" railscasts カラースキーム
  NeoBundle 'jpo/vim-railscasts-theme'
" pyte カラースキーム
  NeoBundle 'therubymug/vim-pyte'
" molokai カラースキーム
  NeoBundle 'tomasr/molokai'

" カラースキーム一覧表示に Unite.vim を使う
  NeoBundle 'ujihisa/unite-colorscheme'


" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"色設定の適用
syntax on
colorscheme hybrid 
highlight Normal ctermbg=none

" ステータスバーの設定
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]\ %{fugitive#statusline()}\ %{virtualenv#statusline()}


