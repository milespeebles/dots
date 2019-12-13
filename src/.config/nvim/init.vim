" providers
if has('mac')
  let g:python_host_prog = '/usr/local/bin/python2.7'
  let g:python3_host_prog = '/usr/local/bin/python3'
elseif has('unix')
  let g:python_host_prog = '/usr/bin/python'
  let g:python3_host_prog = '/usr/bin/python3'
endif



" plugins
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
    \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('~/.local/share/nvim/plugged')

" async
" Plug 'Shougo/vimproc.vim', {'do': 'make'}

" linting
" Plug 'vim-syntastic/syntastic'

" completion
" Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
" Plug 'Raimondi/delimitMate'

" indentation
Plug 'editorconfig/editorconfig-vim'

" color schemes
Plug 'crusoexia/vim-monokai'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" status line
Plug 'itchyny/lightline.vim'

" whitespace highlighting
Plug 'ntpeters/vim-better-whitespace'

" color highlighting
Plug 'chrisbra/Colorizer'

" html
Plug 'alvan/vim-closetag'

" javascript
Plug 'pangloss/vim-javascript'     " js syntax highlighting
Plug 'mxw/vim-jsx'                 " jsx syntax highlighting
Plug 'leafgarland/typescript-vim'  " ts syntax highlighting
Plug 'peitalin/vim-jsx-typescript' " tsx syntax highlighting
Plug 'jason0x43/vim-js-indent'     " js / ts indentation
" Plug 'Quramy/tsuquyomi'            " tsserver client
" Plug 'burner/vim-svelte'           " svelte support

" markdown
Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

" fzf
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" bufkill
Plug 'qpkorr/vim-bufkill'

" rooter (set vcs directory as $PWD)
Plug 'airblade/vim-rooter'

" vimwiki
Plug 'vimwiki/vimwiki'
Plug 'tbabej/taskwiki'
call plug#end()



" recovery
set noswapfile
set undofile



" leader
let mapleader = "\<space>"



" performance
set lazyredraw
set ttyfast



" number line
set nu
set rnu



" wrapping
set nowrap
set linebreak



" indentation
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set smarttab



" backspace
set backspace=indent,eol,start



" status line
set noshowmode



" search
set incsearch
set hlsearch



" buffers
set hidden



" comments
au FileType * setlocal formatoptions-=cro



" autosave
au FocusLost * silent! wa
au FocusGained,BufEnter * :checktime
set autowriteall
set autoread



" colors
set termguicolors
color dracula
" color base16-material
" color monokai
" color default
" set termguicolors&



" completion
set completeopt-=preview



" window title
set title



" mouse
:set mouse=a



" git
let $GIT_EDITOR = 'nvr -cc split --remote-wait'



" keybinds
set pastetoggle=<F2>
nnoremap <silent> <Leader>c :noh<CR>
nnoremap ; :



" lightline
let g:lightline = { 'colorscheme': 'dracula' }



" closetag
let g:closetag_filenames = '*.html, *.xhtml, *.php, *.jsx, *.js, *.tsx, *.ts'



" colorizer
let g:colorizer_auto_color = 1



" youcompleteme
" if !exists('g:ycm_semantic_triggers')
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_show_diagnostics_ui = 0



" syntastic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_aggregate_errors = 1



" fzf
let $BAT_THEME = 'base16'
let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir HFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <leader>ff :Buffers<CR>
nnoremap <silent> <leader>fa :Files <CR>
nnoremap <silent> <leader>fg :Ag<CR>
nnoremap <silent> <leader>fp :HFiles ~/dev<CR>
nnoremap <silent> <leader>fd :HFiles ~/sync/dots<CR>
nnoremap <silent> <leader>fn :Files ~/sync/notes<CR>



" vimwiki
let g:vimwiki_list = [{'path': '$SYNCDIR/notes', 'syntax': 'markdown', 'ext': '.md'}]
let g:taskwiki_markup_syntax = 'markdown'



" javascript
" let g:jsx_ext_required = 0
" let g:ycm_semantic_triggers['typescript'] = ['.']
" let g:tsuquyomi_disable_quickfix = 1
" let g:tsuquyomi_javascript_support = 1
" let g:tsuquyomi_completion_detail = 1
" let g:tsuquyomi_completion_preview = 1
" let g:syntastic_javascript_checkers = ['eslint', 'tsuquyomi']
" let g:syntastic_typescript_checkers = ['tslint', 'tsuquyomi']



" autosave
" function Prettier()
"   :!prettier --write --plugin-search-dir="$PWD" "$PWD/**/*"
"   :e
" endfunction

" autocmd BufWritePost * silent! exec Prettier() <afile>



" vimwiki
nnoremap <silent> <Leader>tr :TaskWikiBufferLoad<CR>



" save / copy
nnoremap <C-s> "+p
inoremap <C-s> <C-O>"+p
vnoremap <C-s> "+p
vnoremap <C-c> "+y

