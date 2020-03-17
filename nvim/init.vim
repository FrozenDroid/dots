function! g:BuffetSetCustomColors()
    hi! BuffetCurrentBuffer ctermfg=0 ctermbg=3
    hi! BuffetTab ctermfg=13 guibg=#000000 guifg=#000000   
endfunction

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'leafgarland/typescript-vim'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-sleuth'
Plug 'godlygeek/tabular'

Plug 'cespare/vim-toml'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'bagrat/vim-buffet'

call plug#end()

" Preferences
set mouse=a
colorscheme base16-tomorrow-night
set signcolumn=yes
set hidden
set cmdheight=2
set background=dark

" Mappings
let mapleader = "\<Space>"
let maplocalleader = mapleader

autocmd CursorMoved * silent call CocActionAsync('highlight')
autocmd CursorMovedI * silent call CocActionAsync('highlight')

set wildmode=longest,list

" File actions
nnoremap <silent> <C-s>      :<C-u>w<bar>set cmdheight=1<CR>
inoremap <silent> <C-s>      <Esc>:w<bar>set cmdheight=1<CR>

nnoremap <silent> <A-left>   <C-left>
inoremap <silent> <A-left>   <C-left>

nnoremap <silent> <A-right>   <C-right>
inoremap <silent> <A-right>   <C-right>

" NERD Tree
nnoremap <silent> <leader>nt :<C-u>NERDTreeToggle<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> ga <Plug>(coc-code-action)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Tabularize
noremap  <silent> <leader>t, :Tabularize /,\zs /l0<CR>
noremap  <silent> <leader>t. :Tabularize /=>\\|->\\|>><CR>
noremap  <silent> <leader>t< :Tabularize /<=\\|<-<CR>
noremap  <silent> <leader>t: :Tabularize /^[^:]*:\zs /l0<CR>
noremap  <silent> <leader>t; :Tabularize /^[^:]*:\zs /l0<CR>
noremap  <silent> <leader>t= :Tabularize /^[^=]* \zs=\ze <CR>
noremap  <silent> <leader>t\ :Tabularize /<bar><CR>

" Match opening symbol
inoremap <silent> {<CR>      {<CR>}<C-o>O
inoremap <silent> [<CR>      [<CR>]<C-o>O
inoremap <silent> (<CR>      (<CR>);<C-o>O
inoremap <silent> ({<CR>     ({<CR>});<C-o>O

" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" FZF
nnoremap 	<leader>sf :<C-u>GFiles<CR>
nnoremap 	<leader>sF :<C-u>Files<CR>
nnoremap	<leader>sb :<C-u>Buffers<CR>

" Termdebug
nnoremap        <leader>tdb :<C-u>Termdebug 

" Buffet
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

noremap <Tab>           :bn<CR>
noremap <S-Tab>         :bp<CR>
noremap <Leader><Tab>   :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t>           :tabnew split<CR>

let g:buffet_powerline_separators = 1
let g:buffet_tab_icon             = "\uf00b"
let g:buffet_left_trunc_icon      = "\uf0a8"
let g:buffet_right_trunc_icon     = "\uf0a9"

let termdebugger     = "arm-none-eabi-gdb"
let g:termdebug_wide = 90

