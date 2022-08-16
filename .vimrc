syntax on

set encoding=UTF-8
set mouse=a
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set updatetime=300
set cmdheight=2
set shortmess+=c
set foldmethod=indent
set noshowmode
" Allow for paste to also work outside neovim
set clipboard=unnamed

" Fix foldings
au BufWinEnter * normal zR

" Use ripgrep instead of default grep for searching
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Use tab or trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
:verbose imap <tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

call plug#begin('~/.vim/plugged')
" Visual 
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
'
" Panels
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto Completions / Helpers
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'

" Language Support & linting
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'leafgarland/typescript-vim'
Plug 'ap/vim-css-color'
Plug 'posva/vim-vue'
Plug 'dense-analysis/ale'
Plug 'digitaltoad/vim-pug'

call plug#end()
" mapleader to space
let mapleader = " "

" Plugin configuration
colorscheme gruvbox
set background=dark
let NERDTreeShowHidden = 1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" fzf dont search for file name as addition to phrase
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"" Mappings
" Disable arrow keys for all modes
for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'cnoremap' key '<Nop>'
endfor

" Scroll through page
map <C-j> <PageDown> 
map <C-k> <PageUp>

nnoremap <leader>q :quit<CR>
nnoremap <leader>w :update<CR>

" Search
nnoremap <leader>s /
" Search in files 
" Make sure ripgrep is installed
nnoremap <leader>S :Rg<CR>

" New tab
nnoremap <leader>. :tabnew<CR>

noremap <C-l> gt
noremap <C-h> gT

" Redraw screen
nnoremap <leader>c :nohl<CR>

nnoremap <leader>z :NERDTreeToggle<CR>
" Search for files
nnoremap <leader>f :Files<CR>

"Open terminal
nnoremap <leader>- :term<CR>i
"Close terminal
tnoremap <Esc> <C-\><C-n>

autocmd BufLeave * if &filetype == "fzf" | call feedkeys("\<C-\>\<C-n>") | endif