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
" Use ESC to move from insert mode to normal mode, in terminal mode
" :tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""""""""""""""""""""""""""""""
"
"           APPEARANCE / VISUAL
"
"""""""""""""""""""""""""""""""""""""""""""""""

" Visual colourscheme taken from the Nightfox Plugin
colorscheme nightfox

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
