"basic command
set encoding=utf-8
set nu
"set mouse=r
"set mouse-=a
set mouse=a
set shiftwidth=4
set ts=4
set expandtab
set hlsearch
set incsearch
set guifont=FiraCode\ Nerd\ Font\ Mono
"set guifont=FiraCode\ NF\ :h10
"set guifont=FiraCode NF weight=453 10
"set guifont="FiraCode\ NFM\ Retina\ :h10:cANSI:qDRAFT"
"set autoindent
set tags=./.tags;,.tags
inoremap jk <esc>
noremap j jzz
nnoremap k kzz
nnoremap <esc> :noh<cr>


let mapleader = "-"
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>eb :edit $BASHLC<cr>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>r :RtlTree<cr>
nmap <leader>w :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

call plug#begin()
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'scrooloose/nerdtree'
Plug 'HonkW93/automatic-verilog'
Plug 'sophacles/vim-processing'
"Plug 'navarasu/onedark.nvim'
Plug 'joshdick/onedark.vim'
Plug 'habamax/vim-godot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'ryanoasis/vim-devicons'
"Plug 'ycm-core/YouCompleteMe'
call plug#end()

syntax on
colorscheme onedark

nmap <silent> <F8> <Plug>MarkdownPreview        " for normal mode
imap <silent> <F8> <Plug>MarkdownPreview        " for insert mode
nmap <silent> <F9> <Plug>StopMarkdownPreview    " for normal mode
imap <silent> <F9> <Plug>StopMarkdownPreview    " for insert mode

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
"        exec "!g++ % -o %<"
        exec "!g++ % `pkg-config --cflags --libs systemc` -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

let g:processing_doc_style = 'local'
let g:processing_doc_path = '~/processing-4.1.2/modes/jave/examples/'
"autocmd FileType processing set tags+=~/processing-4.1.2/processing_tags | set tabstop=4 | set shiftwidth=4 | set softtabstop=4

"----------airline------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1        "显示buffer编号
let g:airline#extensions#tabline#buffer_nr_format = '%s:'
let g:airline#extensions#battery#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_theme='onedark'       " 需要安装joshdick/onedark.vim主题插件


"for verilog.automatic
" 定义一个函数，用于插入文本  
function! InsertInstantiatedModule(module_name)  
    execute "normal! o" . a:module_name . " u_" . a:module_name . "(/*autoinst*/);"
    call g:AutoInst(0)
endfunction  
" 定义一个新的 Ex 命令 :INST，它接受一个参数并调用上面的函数  
command! -nargs=1 INST call InsertInstantiatedModule(<f-args>)

source /home/liurs/verilog/tools/vtags/vtags-3.11/vtags_vim_api.vim
