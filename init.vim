" Remap <SPACE> to nothing ('<Nop>' being Vim's 'serve no purpose' placeholder) so that we can set it as <LEADER> in the next step.
nnoremap <SPACE> <Nop>
:let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""
"
"          PLUGINS (vim-plug)
"
"""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

Plug 'github/copilot.vim'

" Colourscheme
Plug 'EdenEast/nightfox.nvim'

" fzf fuzzyfinder. Useful for **everything**.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Filesystem explorer
Plug 'preservim/nerdtree'

" Comment stuff out with `gcc`
Plug 'tpope/vim-commentary'

" Vim sugar for some UNIX shell commands
Plug 'tpope/vim-eunuch'

" Rails-specific commands. See mappings further down. `gf`, `:A`, `:R` and
" `:Emodel!` are particularly useful.
Plug 'tpope/vim-rails'

" Use gr + motion to replace with register (eg griw to replace current word)
Plug 'vim-scripts/ReplaceWithRegister'

" Pretty markdown preview
Plug 'ellisonleao/glow.nvim', {'branch': 'main'}

" Language Server Protocol setup
Plug 'neovim/nvim-lspconfig'

" Applies configuration from any .editorconfig files
Plug 'gpanders/editorconfig.nvim'

" Test runner
Plug 'vim-test/vim-test'

" Mostly for syntax highlighting
Plug 'plasticboy/vim-markdown'

" Language parser - useful for better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Notetaking and todo lists
Plug 'vimwiki/vimwiki'

" Move cursor to next occurence of "ab" with `sab` (then `;` for subsequent
" matches)
Plug 'justinmk/vim-sneak'

" Snippets engine then the actual snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Git blame
Plug 'f-person/git-blame.nvim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""
"
"           VIM SETTINGS
"
"""""""""""""""""""""""""""""""""""""""""""""""
" Ignore case by default when searching or substituting
:set ignorecase
" Searching for uppercase is case sensitive (ie, overrides the ignorecase setting
" above for uppercase searches)
:set smartcase
" Show current line number (as the absolute line number)
:set number
" Show relative line numbers (except for current line, which remains absolute)
set relativenumber             
" Set a bit more left spacing before linenumber than default (which is 4)
:set numberwidth=5
" Use the system clipboard, allowing copy+pasting from vim to another program,
" and vice versa.
set clipboard+=unnamedplus

filetype indent plugin on
"""""""""""""""""""""""""""""""""""""""""""""""
"
"           MAPPINGS
"
"""""""""""""""""""""""""""""""""""""""""""""""
" Philosophy: I try to follow Doom's lead for leader mappings: https://github.com/doomemacs/doomemacs/blob/master/modules/config/default/+evil-bindings.el
" I used Doom for a long time, and having mnemonic namespacing (eg `<leader> s` as the beginning of all search commands) made everything very memorable and discoverable.
"
" BUFFERS: LEADER + b
" 
" Open fzf filepicker for filenames of open buffers
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>b] :bnext<CR>
nnoremap <leader>b[ :bprevious<CR>
"
" SEARCH: LEADER + s
" Open fzf filepicker for all files known to git
nnoremap <leader><leader> :GFiles<CR>

" Fuzzy search current project (memory tip: SearchProject)
nnoremap <leader>sp :Rg<CR>

" Search a particular directory, like this: `:Rg2 search_term directory_name`
" Taken from https://github.com/junegunn/fzf.vim/issues/837#issuecomment-1179386300
command! -bang -nargs=* Rg2
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" WINDOW NAVIGATION: LEADER + w
" Use <leader> w to navigate between windows
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wc :close<CR>
nnoremap <leader>wh <c-w>h
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l
nnoremap <leader>ww <c-w>w " Toggle back and forth between open windows

" Yank local filepath of current buffer
nnoremap <leader>fY :let @+=expand("%")<CR>
nnoremap <leader>fs :w<CR>

" NERDTree
" Find and reveal file for the active buffer in NERDTree 
nnoremap <leader>op :NERDTreeFind<CR>
" Close NERDTree
nnoremap <leader>oP :NERDTreeClose<CR>

" Use 'jk' to exit insert mode (quicker than pressing <ESC>)
inoremap jk <Esc>

" VIM-RAILS: MAPPINGS
" Open the test file corresponding to the current file (and vice
" versa)
nnoremap <leader>a :A<CR>

" TERMINAL MODE
" Use ESC to move from insert mode to normal mode (but not if currently in an
" fzf preview). See: https://github.com/junegunn/fzf.vim/issues/544#issuecomment-457456166
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au FileType fzf tunmap <buffer> <Esc>

" VIM-TEST
let test#strategy = "neovim"
let test#neovim#term_position = "vert"
" Prepend all the vim-test commands so they run in docker container
" (Obviously, this will only work for latanaapp)
let g:test#ruby#rspec#executable='docker exec -t -e RAILS_ENV=test latanaapp rspec'

nnoremap <leader>t :TestNearest<CR>
nnoremap <leader>T :TestFile<CR>

" 
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
"""""""""""""""""""""""""""""""""""""""""""""""
"
"           APPEARANCE / VISUAL
"
"""""""""""""""""""""""""""""""""""""""""""""""

" Visual colourscheme taken from the Nightfox Plugin
colorscheme nightfox

" Tell Vim that Jenkins files are really Groovy files (which they are), to syntax highlight correctly
" https://ls3.io/posts/jenkinsfile_vim_highlighting/
au BufNewFile,BufRead Jenkinsfile setf groovy

"""""""""""""""""""""""""""""""""""""""""""""""
"
"           PLUGIN SETTINGS
"
"""""""""""""""""""""""""""""""""""""""""""""""
" Treesitter
" Run the following command to download any languages you need
" :TSInstall <language_to_install>

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "ruby", "typescript", "javascript", "html", "css", "vim", "dockerfile", "bash", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
EOF

" VIM-MARKDOWN
let g:vim_markdown_folding_disabled = 1 " Disable default folding in markdown because it's annoying

" VimWiki
nmap <Leader>vv <Plug>VimwikiIndex
let g:vimwiki_list = [{'path': '~/notes/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

au FileType vimwiki setlocal shiftwidth=2 noexpandtab

" GIT BLAME
let g:gitblame_enabled = 0 "Disable on startup

"""""""""""""""""""""""""""""""""""""""""""""""
"
"           COMMANDS
"
"""""""""""""""""""""""""""""""""""""""""""""""

" Commands to edit specific Dotfiles
command! Vimrc e ~/dotfiles/init.vim
command! Zshrc e ~/dotfiles/zshrc
command! Gitconfig e ~/dotfiles/gitconfig
command! Brewfile e ~/dotfiles/Brewfile

" Easier-to-type source vimrc command
command! Sourcevimrc source $MYVIMRC | echo 'Succesfully sourced your init.vim!'

" Command to edit todo file
command! Todo e ~/notes/Todo_Today.md

"""""""""""""""""""""""""""""""""""""""""""""""
"
"       LSP (Language Server Protocol)
"
"""""""""""""""""""""""""""""""""""""""""""""""
" The following section is copied from
" https://github.com/neovim/nvim-lspconfig#suggested-configuration

lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig').solargraph.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
EOF
