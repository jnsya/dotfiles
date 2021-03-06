set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/bundle/LanguageClient-neovim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Filetree explorer
Plugin 'preservim/nerdtree'

" Nice colour scheme
Plugin 'morhetz/gruvbox'

" Command-line fuzzy finder search
Plugin 'junegunn/fzf'

" Also required for the command-line fuzzy finder search
Plugin 'junegunn/fzf.vim'

" Git wrapper
Plugin 'tpope/vim-fugitive'

" Git visualisation 
Plugin 'idanarye/vim-merginal'

" Comment stuff out with gcc
Plugin 'tpope/vim-commentary'

" Runs rspec tests
Plugin 'thoughtbot/vim-rspec'

" Align stuff
Plugin 'junegunn/vim-easy-align'

" Automatically add end after if/do/class/def...
Plugin 'tpope/vim-endwise'

Plugin 'jiangmiao/auto-pairs'

Plugin 'neoclide/coc.nvim'

Plugin 'burnettk/vim-angular'

Plugin 'pangloss/vim-javascript'

" Hybrid of relative and absolute line numbers
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

Plugin 'elzr/vim-json'

Plugin 'vim-utils/vim-ruby-fold'

Plugin 'autozimu/LanguageClient-neovim'

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'tpope/vim-surround'

Plugin 'chiel92/vim-autoformat'

call vundle#end()            

" Basics ---------------------------------------------------------------- {{{
:let mapleader = " "
filetype plugin on " Without this, Vundle weirdly would not load plugins: https://github.com/VundleVim/Vundle.vim/issues/679
set modelines=0		" More security
set colorcolumn=118
syntax on 	   " Enable syntax highlighting
filetype on 	   " Re-enable filetype detection (OK to re-enable after last Vundle command)
filetype indent on " Enable filetype-specific indenting

" Disable arrow keys so I learn to navigate the vim way :)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" No beeping!
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set background=dark    		             " Setting dark mode
autocmd vimenter * colorscheme gruvbox " See https://github.com/morhetz/gruvbox/wiki/Installation

" size of a hard tabstop
set tabstop=2
	
" always uses spaces instead of tab characters
set expandtab

" size of an "indent"
set shiftwidth=2

" copied from https://github.com/tpope/vim-sensible
set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal
set laststatus=2
set ruler
set wildmenu
set autoread
" }}}

let NERDTreeShowHidden=1

" F5 to select then switch buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" Saves swap files to this directory so they don't clutter up my actual file
set directory^=$HOME/.vimswap//

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

:set number relativenumber

" Ctrl-j/k deletes blank line below/above
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>

" Start interactive EasyAlign (align) in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>

" 
nmap <Leader>v :vsplit<CR>
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Search for highlighted word in visual mode
vnoremap // y/<C-R>"<CR>"

" Search  ---------------------------------------------------------------- {{{
set hlsearch
set incsearch

" Redraws the screen and removes any search highlighting
nnoremap <silent> <C-c> :nohl<CR><C-c>

" Toggle tree in directory of current buffer
map <C-o> :NERDTreeToggle %<CR>

" Use ripgrep instead of grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Use fzf for fuzzy filename search and in-file search
nnoremap <C-t> :Files<Cr>
nnoremap <C-f> :Rg<Cr>

" (R)eplace current word (with confirmation)
nnoremap <leader>r yiw:%s/\<<C-r>"\>//gc<left><left><left>

" Command to ignore filename when searching, but it also gets rid of the
" preview box.
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" }}}

" Folding ---------------------------------------------------------------- {{{
" fold everything with zm
" unfold everything with zr
set foldmethod=syntax   "fold based on syntax (except for haml below)
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
autocmd BufNewFile,BufRead *.haml setl foldmethod=indent nofoldenable
autocmd! FileType nofile setl foldmethod=indent nofoldenable
" }}}

" Copy paste ---------------------------------------------------------------- {{{

" Copy filepath to clipboard with ,cs
nmap ,cs :let @*=expand("%")<CR>

" Use cliboard as default register
set clipboard=unnamed

" }}}

" Conquer of Completion  ---------------------------------------------------------------- {{{

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = ['coc-solargraph']

" }}}

" split navigation ---------------------------------------------------------------- {{{
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" }}}

let g:vim_json_syntax_conceal = 0

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'ruby': ['/Users/jnsya/.asdf/shims/solargraph', 'stdio'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

