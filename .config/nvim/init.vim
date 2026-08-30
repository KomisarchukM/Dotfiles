" ── Plugin manager (vim-plug) ────────────────────
call plug#begin()

" CoC — LSP client (C++ via clangd)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Color theme
Plug 'neanias/everforest-nvim', {'branch': 'release'}

" NerdTree file explorer
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'    " icons in NerdTree

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Colorizer — highlight CSS/hex colors inline
" Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

" ── Theme ────────────────────────────────────────
colorscheme everforest
set termguicolors
highlight Normal guibg=NONE ctermbg=NONE
highlight SignColumn guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE
highlight CursorLineNr guibg=NONE ctermbg=NONE

" ── General ──────────────────────────────────────
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set smartindent
set hidden        " required by CoC
set updatetime=300
set signcolumn=yes
set encoding=utf-8

" ── NerdTree ─────────────────────────────────────
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.git$', 'node_modules$', 'build$']
" Close nvim if NerdTree is the only window left
autocmd BufEnter * if tabpagenr('$')==1 && winnr('$')==1
  \ && exists('b:NERDTree') && b:NERDTree.isTabTree()
  \ | quit | endif

" ── CoC keymaps ──────────────────────────────────
" Use Tab to trigger completion
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Go to definition / references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Hover docs
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Rename symbol
" nmap <leader>rn <Plug>(coc-rename)

" ── Colorizer (lua plugin, loaded via vimscript) ─
" lua require('colorizer').setup()


" ── Run C++ ───────────────────────────────────────
function! RunCpp()
  belowright 10split
"                   | use bash if have
  execute 'terminal sh -c "g++ ' . expand('%') . ' -o ' . expand('%:r') . ' && ./' . expand('%:r') . '"'
  startinsert
endfunction

nnoremap <F5> :call RunCpp()<CR>
set clipboard+=unnamedplus
