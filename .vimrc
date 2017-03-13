set exrc
set secure

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set cindent
set number
"set mouse=a
"set mousefocus
set relativenumber
inoremap <CR> <CR>d<BS>

syntax on
"colorscheme monokai
colorscheme peachpuff
"colorscheme alduin
let g:solorized_termcolors=256
set t_Co=256
let g:cpp_class_scope_highlight = 1

if version >= 700
    if has("gui_running")
        au InsertEnter * hi StatusLine guifg=black guibg=green
        au InsertLeave * hi StatusLine guibg=black guifg=grey
    else
        au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
        au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
    endif
endif

set whichwrap+=<,>,[,]

augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

let &path.="src/include,/usr/include/AL,"

au BufEnter *.c compiler gcc

inoremap <F5> <ESC> :write <CR> :!g++ -o run % <CR>
nnoremap <F5> :write <CR> :!g++ -o run % <CR>
inoremap <F6> <ESC> :!./run <CR>
nnoremap <F6> :!./run <CR>
inoremap <F10> <ESC> :wq <CR>
nnoremap <F10> :wq <CR>
inoremap <F3> <ESC> :q! <CR>
nnoremap <F3> :q! <CR>

inoremap <F7> <ESC> :tabp <CR>
nnoremap <F7> :tabp <CR>
inoremap <F8> <ESC> :tabn <CR>
nnoremap <F8> :tabn <CR>

inoremap <F2> <ESC> :write <CR> :!php % <CR>
nnoremap <F2> :write <CR> :!php % <CR>

inoremap <F4> <ESC> :w <CR> a
nnoremap <F4> :w <CR>

inoremap { {<CR>d<CR>}<up><right><right><BS>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap " ""<left>
" inoremap ' ''<left>
