" Remap <SPACE> to nothing ('<Nop>' being Vim's 'serve no purpose' placeholder) so that we can set it as <LEADER> in the next step.
nnoremap <SPACE> <Nop>
:let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""
"
"          PLUGINS (vim-plug)
"
"""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

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

" Test runner
Plug 'vim-test/vim-test'

" Mostly for syntax highlighting
Plug 'plasticboy/vim-markdown'

" Language parser - useful for better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Notetaking and todo lists
Plug 'vimwiki/vimwiki'

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

" NERDTree
" Find and reveal file for the active buffer in NERDTree 
nnoremap <leader>op :NERDTreeFind<CR>
" Close NERDTree
nnoremap <leader>oP :NERDTreeClose<CR>

" Use 'jj' to exit insert mode (quicker than pressing <ESC>)
inoremap jj <Esc>

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

" VIM-MARKDOWN
let g:vim_markdown_folding_disabled = 1 " Disable default folding in markdown because it's annoying

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "ruby", "markdown", "json" },

  indent = {
    enable = true
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time (which can be slow)
    additional_vim_regex_highlighting = false,
  },
}
EOF

" VimWiki
nmap <Leader>vv <Plug>VimwikiIndex
let g:vimwiki_list = [{'path': '~/notes/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

au FileType vimwiki setlocal shiftwidth=2 noexpandtab
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
