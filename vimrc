set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

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

" Comment stuff out with gcc
Plugin 'tpope/vim-commentary'

call vundle#end()            

filetype plugin on " Without this, Vundle weirdly would not load plugins: https://github.com/VundleVim/Vundle.vim/issues/679

" Put your non-Plugin stuff after this line

" Following taken from https://stevelosh.com/blog/2010/09/coming-home-to-vim/#s1-some-background-about-me
set modelines=0		" More security

set colorcolumn=118

syntax on 	   " Enable syntax highlighting
filetype on 	   " Re-enable filetype detection (OK to re-enable after last Vundle command)
filetype indent on " Enable filetype-specific indenting
" filetype plugin on " Enable filetype-specific plugins

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

set background=dark    		             " Setting dark mode
autocmd vimenter * colorscheme gruvbox " See https://github.com/morhetz/gruvbox/wiki/Installation

" Toggle tree in directory of current buffer
map <C-o> :NERDTreeToggle %<CR>

" Use fzf for fuzzy filename search and in-file search
nnoremap <C-t> :Files<Cr>
nnoremap <C-f> :Rg<Cr>

" size of a hard tabstop
set tabstop=2
	
" always uses spaces instead of tab characters
set expandtab

" size of an "indent"
set shiftwidth=2

let NERDTreeShowHidden=1

" F5 to select then switch buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" Saves swap files to this directory so they don't clutter up my actual file
set directory^=$HOME/.vimswap//

