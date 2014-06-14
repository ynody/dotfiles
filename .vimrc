
set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'git://github.com/Shougo/neocomplcache.git'
" NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
"NeoBundle 'git://github.com/Shougo/vim-vcs.git'
"NeoBundle 'git://github.com/Shougo/vimfiler.git'
"NeoBundle 'git://github.com/Shougo/vimproc.git'
"NeoBundle 'git://github.com/Shougo/vimshell.git'
"NeoBundle 'git://github.com/Shougo/vinarise.git'
NeoBundle 'git://github.com/scrooloose/nerdcommenter.git'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'claco/jasmine.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundleCheck
filetype plugin indent on

set vb
set number
set cursorline

filetype on
filetype indent on
filetype plugin on
syntax on

set mouse=a
set guioptions+=a
set ttymouse=xterm2

set formatoptions+=ro

"source $VIM/mydir/python.vim

"ステータスラインを常に表示
set laststatus=2
set statusline=%<%f\ %y%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P


"開いたファイルにcd
au BufEnter * execute ":lcd " . expand("%:p:h")
au! BufNewFile,BufRead *.jsx :set filetype=javascript
au BufRead,BufNewFile,BufReadPre *.cofee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et

" 大文字が含まれている時のみ、大文字と小文字が区別される
set ignorecase smartcase 
" 検索結果の強調表示する
set hlsearch 

set tags=tags
" c ->cpp
au BufNewFile,BufRead *.c setf cpp

"インデント幅
set shiftwidth=4
"TABはスペースいくつ分か
set tabstop=8

"インデントするときはTAB使わない（<C-V><TAB>, <C-V><C-I>以外でTABが打てなくなる）
set expandtab

"setlocal omnifunc=pythoncomplete#Complete
if has('autocmd')
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
endif



""" unite.vim
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,fb :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,ff :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,fr :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,fm :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,fu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,fa :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q


" When insert mode, change statusline.
let g:hi_insert = 'hi StatusLine gui=None guifg=Black guibg=Yellow cterm=None ctermfg=Black ctermbg=Yellow'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


"NeoComplCache
let g:neocomplcache_enable_at_startup = 1


" Nerd Commenter
let g:NERDCreateDefaultMappings = 1
let NERDSpaceDelims = 1

" <leader>の変更
let mapleader = ","


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" if &encoding !=# 'utf-8'
  " set encoding=japan
" endif
" set fileencoding=japan
" if has('iconv')
  " let s:enc_euc = 'euc-jp'
  " let s:enc_jis = 'iso-2022-jp'
  " " iconvがJISX0213に対応しているかをチェック
  " if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    " let s:enc_euc = 'euc-jisx0213'
    " let s:enc_jis = 'iso-2022-jp-3'
  " endif
  " " fileencodingsを構築
  " if &encoding ==# 'utf-8'
    " let s:fileencodings_default = &fileencodings
    " let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    " let &fileencodings = &fileencodings .','. s:fileencodings_default
    " unlet s:fileencodings_default
  " else
    " let &fileencodings = &fileencodings .','. s:enc_jis
    " set fileencodings+=utf-8,ucs-2le,ucs-2
    " if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      " set fileencodings+=cp932
      " set fileencodings-=euc-jp
      " set fileencodings-=euc-jisx0213
      " let &encoding = s:enc_euc
    " else
      " let &fileencodings = &fileencodings .','. s:enc_euc
    " endif
  " endif
  " unlet s:enc_euc
  " unlet s:enc_jis
" endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme wombat256mod

""" coffee
" taglistの設定 coffeeを追加
" let g:tlist_coffee_settings = 'coffee;f:function;v:variable'

" QuickRunのcoffee
" let g:quickrun_config['coffee'] = {
"      \'command' : 'coffee',
"      \'exec' : ['%c -cbp %s']
"      \}

"------------------------------------
" vim-coffee-script
"------------------------------------
" 保存時にコンパイル
autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!

"------------------------------------
" jasmine.vim
"------------------------------------
" ファイルタイプを変更
function! JasmineSetting()
  au BufRead,BufNewFile *Helper.js,*Spec.js  set filetype=jasmine.javascript
  au BufRead,BufNewFile *Helper.coffee,*Spec.coffee  set filetype=jasmine.coffee
  au BufRead,BufNewFile,BufReadPre *Helper.coffee,*Spec.coffee  let b:quickrun_config = {'type' : 'coffee'}
  call jasmine#load_snippets()
  map <buffer> <leader>m :JasmineRedGreen<CR>
  command! JasmineRedGreen :call jasmine#redgreen()
  command! JasmineMake :call jasmine#make()
endfunction
au BufRead,BufNewFile,BufReadPre *.coffee,*.js call JasmineSetting()

"------------------------------------
" indent_guides
"------------------------------------
" インデントの深さに色を付ける
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_color_change_percent=20
let g:indent_guides_guide_size=1
let g:indent_guides_space_guides=1

hi IndentGuidesOdd  ctermbg=235
hi IndentGuidesEven ctermbg=237
au FileType coffee,ruby,javascript,python IndentGuidesEnable
nmap <silent><Leader>ig <Plug>IndentGuidesToggle
