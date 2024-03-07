:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set scrolloff=10
let g:startify_header=['test']

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
" Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/mg979/vim-visual-multi' " CTRL + N for multiple cursors
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
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' 
Plug 'ObserverOfTime/coloresque.vim'
Plug 'ggandor/leap.nvim'
Plug 'puremourning/vimspector'
" LSP Support
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional
" Autocompletion
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'L3MON4D3/LuaSnip'     " Required
Plug 'mhinz/vim-startify'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'haydenmeade/neotest-jest'
Plug 'nvim-neotest/neotest-plenary'
call plug#end()
lua <<EOF
require('neotest').setup({
      ...,
      adapters = {
        require('neotest-jest')({
          jestCommand = "yarn test",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
}),require("neotest-plenary"),
}})
EOF
lua <<EOF

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
EOF

lua <<EOF
-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})
EOF




set encoding=UTF-8

lua require('leap').add_default_mappings()
"leader
let mapleader = "\<Space>"
"telescope
nnoremap <leader>f <cmd>Telescope git_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
"harpoon
nnoremap <leader>a <cmd>lua require"harpoon.mark".add_file()<cr>
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
nnoremap <leader>v :split<CR>
nnoremap <leader>c :vsplit<CR>
nnoremap <leader>x :Gdiffsplit<CR>
nnoremap <leader>] :10winc -<CR>
nnoremap <leader>[ :10winc +<CR>
nnoremap <leader>. :30winc ><CR>
nnoremap <leader>, :30winc <<CR>
tnoremap <Esc> <C-\><C-n>
"zoom-in-out
nnoremap <leader>o :let g:neovide_scale_factor -= 0.5<CR>:let g:neovide_scale_factor<CR>
nnoremap <leader>i :let g:neovide_scale_factor += 0.5<CR>:let g:neovide_scale_factor<CR>

"tabs
nnoremap <leader>nt :tabnew term://powershell<CR>
nnoremap L :tabl<CR>
nnoremap H :tabr<CR>
nnoremap <C-x> :tabclose<CR>
					
"usefull itens
inoremap <C-t> \|
inoremap <C-r> \

"fast coments
vnoremap <C-k> :norm i//<CR>
vnoremap <C-l> :norm 2x/<CR>  


nmap <F8> :TagbarToggle<CR>

" autocmd VimEnter * ++nested :10split term://powershell | wincmd w | wincmd r 
" autocmd VimEnter * ++nested :NERDTreeFocus
":set completeopt-=preview  For No Previews

lua << EOF
	require'nvim-treesitter.configs'.setup {
	ensure_installed= { "rust", "javascript","c", "lua", "vim"},
	sync_install= false,
	auto_install = true,
	ignore_install = {},
	highlight = {
	enable = true,
	disable = { "c"  },
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
set guifont=DaddyTimeMono\ Nerd\ Font:h10
colorscheme hybrid
" highlight Normal guibg=#232323
 highlight Normal guibg=none
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
highlight @float guifg=#FFDB00
highlight Identifier guifg=#ffc8dd
highlight @comment guifg=#00ff00
highlight Visual guifg=#cccccc guibg=#222222
highlight TabLineSel guifg=#ffdb00 guibg=#444444
highlight TabLine guifg=#ccb900 guibg=#222222
highlight TabLineFill guifg=#000000
highlight CocInlayHint guifg=#ff5555 guibg=#000000

"startify configs

let g:Vimspector_enable_mappings = 'HUMAN'
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
let g:neovide_cursor_vfx_mode="pixiedust"
let g:neovide_cursor_vfx_particle_lifetime=10
let g:neovide_cursor_vfx_particle_opacity=400
let g:neovide_cursor_vfx_particle_density=20
let g:neovide_transparency=1
let g:neovide_fullscreen=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeMapOpenInTab='<C-ENTER>'
let g:prettier#autoformat=1
let g:prettier#autoformat_require_pragma = 0
let g:rustfmt_autosave = 1
let g:coloresque_whitelist = ['css', 'html', 'javascript', 'jsx', 'typescript', 'vim', 'tsx']
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
let g:airline_section_z = '%{strftime("%c")}'



"nerdtree color config 
"disable unmatch
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
"disable highlight
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreePatternMatchHighlightColor = {}
let g:NERDTreePatternMatchHighlightColor['.*test\.ts$'] = s:red
let g:NERDTreePatternMatchHighlightColor['.*test\.tsx$'] = s:red
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:purple " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['vim'] = s:green " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['tsx'] = s:darkBlue " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['html'] = s:orange " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['ts'] = s:lightPurple " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['js'] = s:yellow " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['jsx'] = s:aqua " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['json'] = s:lightGreen " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['rs'] = s:darkOrange " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['toml'] = s:salmon " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['md'] = s:aqua " sets the color of css files to blue

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue" sets the color for files that did not match any rule


let g:NERDTreeSyntaxDisableDefaultExtensions =0
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1

" set g:NERDTreeExtensionHighlightColor if you want a custom color instead of the default one
let g:NERDTreeSyntaxEnabledExtensions = ['hbs', 'lhs'] " enable highlight to .hbs and .lhs files with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['dropbox', 'node_modules', 'favicon.ico'] " enable highlight for dropbox and node_modules folders, and favicon.ico files with default colors
