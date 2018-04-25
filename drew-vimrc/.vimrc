" Fix shell
set shell=/bin/bash

"set virtualedit=onemore

" Exit insert mode
inoremap kj <Esc>
"vnoremap kj <Esc> 
" End and head of a line
"inoremap ;l <End>
"inoremap ;k <Home>
" Text Navigation
"  h -> Up
"  j -> Down
"  k -> Left
"  l -> Right
"  ; -> Home
"  ' -> End
"noremap i k
"noremap h i
"noremap k j
"noremap j h
noremap , a
noremap ; <Home>
noremap ' <End>

" list
nnoremap <F3> :set list<BAR><CR>

" nolist
nnoremap <F4> :set nolist<BAR><CR>

" Kill Trailing WhiteSpace
nnoremap <F5> :let _save = winsaveview()<Bar>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:call winrestview(_save)<Bar><CR>

" Euthenizes tabs
nnoremap <F6> :set expandtab<Bar>:retab<Bar><CR>

" Un-Euthenize tabs
nnoremap <F7> :set noexpandtab<Bar>:retab!<Bar><CR>


" Not compatible with Vi
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Display incomplete commands
set showcmd

" Perform incremental searches
set incsearch

" Vundle
source ~/.vimrc_vundle

" Bundles
source ~/.vimrc_bundles



" Enable mouse
set mouse=a
if !has('nvim')
    set ttymouse=xterm2
endif

" Line numbers
set nu

 " Fix backspace
set backspace=indent,eol,start

" Colors
set t_Co=256
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
colorscheme elflord
syntax on

" python syntax
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"
""" Display checker-name for that error-message
"let g:syntastic_aggregate_errors = 1

"let g:syntastic_python_checkers=['flake8','python3']

" Vim air-line
let g:airline_powerline_fonts=1
" Powerline
set laststatus=2

" Ruler
"set colorcolumn=80

" Invisible character setting
set list
set listchars=eol:$
hi NonText ctermfg=22

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set et
let g:indentLine_char = '|'
let g:indentLine_color_term = 239

" Smart indenting
set smartindent

" Wrapping, side-scrolling
set nowrap

" Highlight search things
set hlsearch

" When pressing return after typing a comment, don't automatically start a new
" comment
"au FileType * setlocal formatoptions-=r

" When a macro is created on q, let space replay that macro
noremap <Space> @q

" Eliminate delay in switching modes
set timeoutlen=1000 ttimeoutlen=0

" Highlight cursor line
" set cursorline

" Disable spellchecking
set nospell

" Nerd Tree
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "**",
"    \ "Staged"    : "+",
"    \ "Untracked" : "*_",
"    \ "Renamed"   : "->",
"    \ "Unmerged"  : "=",
"    \ "Deleted"   : "xx",
"    \ "Dirty"     : "x_",
"    \ "Clean"     : "GG",
"    \ 'Ignored'   : "_x",
"    \ "Unknown"   : "?"
"    \ }

" Start Deoplete
"call deoplete#enable()

" javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" haskell
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" File type aliases
au BufNewFile,BufRead *.ejs set filetype=jst
au BufNewFile,BufRead *.less set filetype=less

au BufRead,BufNewFile *.go setfiletype go
au BufNewFile,BufRead *.ino set filetype=c
au BufNewFile,BufRead *.pde set filetype=c


" Work directory files (optional)
silent! source .vimrc_settings
