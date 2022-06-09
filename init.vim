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
" Add linenumbers
:set number
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
" SEARCH
" Open fzf filepicker for all files known to git
nnoremap <leader><leader> :GFiles<CR>
" Open fzf filepicker for filenames of open buffers (memory tip: SearchBuffers)
nnoremap <leader>sb :Buffers<CR>

" Fuzzy search current project (memory tip: SearchProject)
nnoremap <leader>sp :Rg<CR>

" WINDOW NAVIGATION
" Use <leader> w to navigate between windows
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wc :close<CR>
nnoremap <leader>wh <c-w>h
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l
nnoremap <leader>ww <c-w>w " Toggle back and forth between open windows

" NERDTree
" Find and reveal file for the active buffer in NERDTree 
nnoremap <leader>op :NERDTreeFind<CR>
" Close NERDTree
nnoremap <leader>oP :NERDTreeClose<CR>

" Use 'jj' to exit insert mode (quicker than pressing <ESC>)
inoremap jj <Esc>

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
