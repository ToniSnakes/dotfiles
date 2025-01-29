set exrc
set secure

syntax on
filetype plugin indent on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smarttab
"set cindent
set number
"set mouse=a
"set mousefocus
set relativenumber
inoremap <CR> <CR>d<BS>
inoremap # <Tab><BS>#
map <C-b> :NERDTreeToggle<CR>
map <C-i> ysiw

set rtp+=/usr/bin/fzf
map <C-p> :Files<CR>
map <C-f> :Ag<CR>

"let $FZF_DEFAULT_COMMAND = 'ag --nogroup --nocolor --column --hidden'
let g:ackprg = 'ag --nogroup --nocolor --column --hidden'

"command! -bang -nargs=* Agc call fzf#vim#grep('ag  --nogroup --column --filename --color -- '.shellescape(empty(<q-args>) ? '^(?=.)' : <q-args>) .. ' ' .. shellescape(expand('%:p')) .. ' /dev/null 2>/dev/null', fzf#vim#with_preview(), <bang>0)

let g:fzf_preview_window = ['right:50%', 'ctrl-_']
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--nogroup --color --column --hidden --filename', fzf#vim#with_preview(), <bang>0)

syntax on
"colorscheme monokai
"colorscheme peachpuff
colorscheme alduin
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

"inoremap <F5> <ESC> :write <CR> :!g++ -o run *.cpp *.h <CR>
"nnoremap <F5> :write <CR> :!g++ -o run *.cpp *.h <CR>
inoremap <F5> <ESC> :w <CR> :!make clean <CR>
nnoremap <F5> :w <CR> :!make clean <CR>
inoremap <F6> <ESC> :!./main <CR>
nnoremap <F6> :!./main <CR>
inoremap <F10> <ESC> :wq <CR>
nnoremap <F10> :wq <CR>

"inoremap <F7> <ESC> :w <CR> :!gcc -std=c99 -Wall -pedantic -o run *.c <CR>
"nnoremap <F7> :w <CR> :!gcc -std=c99 -Wall -pedantic -o run *.c <CR>
"inoremap <F7> <ESC> :w <CR> :!g++-11 --std=c++2a -Wall -o run % <CR>
"nnoremap <F7> :w <CR> :!g++-11 --std=c++2a -Wall -o run % <CR>
inoremap <F7> <ESC> :w <CR> :!make <CR>
nnoremap <F7> :w <CR> :!make <CR>

inoremap <F8> <ESC> :w <CR> :!python3 % <CR>
nnoremap <F8> :w <CR> :!python3 % <CR>

inoremap <F2> <ESC> :write <CR> :!ansible-playbook % -i ../hosts.yml -u antonio <CR>
nnoremap <F2> :write <CR> :!ansible-playbook % -i ../hosts.yml -u antonio <CR>
inoremap <F3> <ESC> :write <CR> :!ansible-playbook % -i ../hosts.yml -u antonio --extra-vars "ansible_sudo_pass=asdf;lkj" <CR>
nnoremap <F3> :write <CR> :!ansible-playbook % -i ../hosts.yml -u antonio --extra-vars "ansible_sudo_pass=asdf;lkj" <CR>

inoremap <F4> <ESC> :w <CR> a
nnoremap <F4> :w <CR>

nnoremap <F9> i// file: <C-R>% <CR>// author: Antonio-Ionut Boar (email: a.boar@student.rug.nl) <CR>// date: <C-R>=strftime("%a %d %b %Y")<CR> <CR>// version: 1.0 <CR><CR>// Description: 

nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

nnoremap <C-m> :set invnumber invrelativenumber<CR>
nnoremap <C-i> :set tabstop=4 softtabstop=4 shiftwidth=4<CR>:let NERDTreeIgnore = ['\.o', '\.a', 'generated_deps', 'main$']<CR>

" inoremap { {<CR>d<CR>}<up><right><right><BS>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap " ""<left>
" inoremap ' ''<left>
execute pathogen#infect()
call pathogen#helptags()
