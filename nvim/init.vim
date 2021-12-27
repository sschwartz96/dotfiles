"""
"  Required to use:
"   * vim-plug
"   * 
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
autocmd Filetype go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
autocmd Filetype svelte setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd Filetype typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd Filetype cjs setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
autocmd Filetype lua setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

inoremap jk <Esc>
nnoremap ]n :cnext <CR>
nnoremap [n :cprev <CR>
set relativenumber number!
set hidden
set completeopt=menu,menuone,noselect
set nowrap
set noswapfile
set scrolloff=7

"Plugins
call plug#begin(stdpath('data') . '/plugged')

" quick config for LSPs
Plug 'neovim/nvim-lspconfig'
" lsp instaler
Plug 'williamboman/nvim-lsp-installer'

" auto completer
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'

" signature
Plug 'ray-x/lsp_signature.nvim'

" snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" color + visuals
Plug 'gruvbox-community/gruvbox'
"Plug 'morhetz/gruvbox'
Plug 'psliwka/vim-smoothie'
Plug 'itchyny/lightline.vim'

" tools
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'preservim/tagbar', { 'on': 'TagBar' }
Plug 'tpope/vim-fugitive'

" editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" web / svelte
Plug 'leafOfTree/vim-svelte-plugin', { 'for': 'svelte' }
Plug 'leafgarland/typescript-vim', { 'for': ['svelte', 'ts'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['svelte', 'css', 'scss'] }

" go
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()


" plugin config
colorscheme gruvbox
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <C-p> :Files<CR>

" Expand or jump
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

" Jump backward
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'

" vim-svelte
let g:vim_svelte_plugin_use_typescript = 1

" css and scss
" au BufRead,BufNewFile *.scss set filetype=scss.css
" au BufRead,BufNewFile *.css set filetype=scss

" lsp_config
lua require("lsp_config")

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
			\ 'colorscheme': 'gruvbox',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'FugitiveHead'
			\  },
			\ }

augroup GO_LSP
	autocmd!
	autocmd BufWritePre *.go :silent! lua GoImports(1000)
	" autocmd BufWritePre *.go :silent! lua vim.lsp.buf.formatting()
augroup END
