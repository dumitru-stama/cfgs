set noswapfile
set clipboard=unnamedplus
set relativenumber
set ignorecase
set smartcase
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cursorline
set wildmenu


let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>
:command Q q

" GO syntax option
let g:go_highlight_trailing_whitespace_error=0
let g:go_highlight_space_tab_error=0
inoremap <C-a> <Home>
inoremap <C-e> <End>

