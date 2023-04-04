:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
Plug 'https://github.com/WhiteBlackGoose/andromeda.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/ThePrimeagen/vim-be-good'
Plug 'tpope/vim-fugitive'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'rust-lang/rust.vim'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'ThePrimeagen/harpoon'

call plug#end()
set encoding=UTF-8
"leader
let mapleader = "\<Space>"
"telescope
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
"harpoon
nnoremap <leader>a <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>h <cmd>lua require("harpoon.ui").nav_prev()<cr>
nnoremap <leader>l <cmd>lua require("harpoon.ui").nav_next()<cr>
nnoremap <leader>m <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <C-j> :10split term://powershell<CR><C-w><C-r><C-w><C-r>
nnoremap <C-s> :w<CR>
nnoremap <C-b> <C-b>zz
nnoremap <C-d> <C-d>zz
"tabs
nnoremap L :tabl<CR>
nnoremap H :tabr<CR>
nnoremap <C-x> :tabclose<CR>

"usefull itens
inoremap <C-p> \|
inoremap <C-r> \

"fast coments
vnoremap <C-k> :norm i//<CR>
vnoremap <C-l> :norm 2x/<CR>  


nmap <F8> :TagbarToggle<CR>

autocmd VimEnter * ++nested :10split term://powershell | wincmd w | wincmd r 
autocmd VimEnter * ++nested :NERDTreeFocus
":set completeopt-=preview  For No Previews

lua << EOF
	require'nvim-treesitter.configs'.setup {
	ensure_installed= { "javascript","c", "lua", "vim", "help"},
	sync_install= false,
	auto_install = true,
	ignore_install = {},
	highlight = {
	enable = true,
	disable = { "c", "rust" },
	disable = function(lang, buf)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
	return true
	end
	end,
	additional_vim_regex_highlighting = false,
	},}
EOF

syntax on
set background=dark
set termguicolors
set guifont=consolas:h10
colorscheme lucid
highlight @tag guifg=#ffffff
highlight @variable guifg=#f72585
highlight @keyword guifg=#00b4d8
highlight @function guifg=#ffc8dd
highlight @string guifg=#ffdb00
highlight @boolean guifg=#ffdb00
highlight @number guifg=#ffdb00
highlight @character guifg=#ffafcc
highlight LineNr guifg=#ffffff guibg=#333333
highlight LineNrAbove guifg=#cf45cd guibg=#333333
highlight LineNrBelow guifg=#ffdb00 guibg=#333333
highlight @float guifg=#ffdb00
highlight Identifier guifg=#ffc8dd
highlight @comment guifg=#00ff00
highlight Visual guifg=#cccccc guibg=#222222
highlight TabLineSel guifg=#ffdb00 guibg=#444444
highlight TabLine guifg=#ccb900 guibg=#222222
highlight TabLineFill guifg=#000000
highlight CocInlayHint guifg=#ff5555 guibg=#000000

let g:neovide_cursor_vfx_mode="pixiedust"
let g:neovide_cursor_vfx_particle_lifetime=10
let g:neovide_cursor_vfx_particle_opacity=400
let g:neovide_cursor_vfx_particle_density=20
let g:neovide_transparency=0.7
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeMapOpenInTab='<C-ENTER>'
let g:prettier#autoformat=1
let g:prettier#autoformat_require_pragma = 0
let g:rustfmt_autosave = 1

" --- Just Some Notes ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "<CR>"
inoremap <silent><expr> <C-space> coc#refresh()
