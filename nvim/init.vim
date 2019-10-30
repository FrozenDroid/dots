call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'leafgarland/typescript-vim'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-sleuth'

Plug 'cespare/vim-toml'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Preferences
set mouse=a
colorscheme base16-tomorrow-night
set signcolumn=yes
set hidden
set cmdheight=2

" Mappings
let mapleader = "\<Space>"
let maplocalleader = mapleader

autocmd CursorMoved * silent call CocActionAsync('highlight')
autocmd CursorMovedI * silent call CocActionAsync('highlight')

" File actions
nnoremap <silent> <C-s>      :<C-u>w<bar>set cmdheight=1<CR>
inoremap <silent> <C-s>      <Esc>:w<bar>set cmdheight=1<CR>

" NERD Tree
nnoremap <silent> <leader>nt :<C-u>NERDTreeToggle<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" FZF
nnoremap 	<leader>sf :<C-u>GFiles<CR>
nnoremap 	<leader>sF :<C-u>Files<CR>

