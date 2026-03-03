# Note: Run `source ~/.zshrc` to reload this file after making changes

##########################################
#
#		OH-MY-ZSH
#
##########################################
# Note: Plugins and Theme need to be loaded BEFORE sourcing the oh-my-zsh config file, or stuff breaks.
# Theme
ZSH_THEME="" # Disabled in favour of Starship (see bottom of file)
# Plugins
# Note: new plugins should be installed at `~/.oh-my-zsh/custom/plugins`, then added to this list.
plugins=(
zsh-syntax-highlighting
fzf-tab # Add functions which use fzf to fuzzy search. eg: fzf-kill to select a process to kill.
)
# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# Loads oh-my-zsh
source $ZSH/oh-my-zsh.sh
# Turn off all beeps
unsetopt BEEP
# Set neovim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

##########################################
#
#		  GIT
#
##########################################
alias lg='lazygit' # open lazygit TUI
# I use these aliases daily
alias gb='fzf-git-branch' # fuzzy search git branch (see fzf section)
alias gco='fzf-git-checkout ' # fuzzy search branch then checkout (see fzf section)
alias gl='git lg ' # pretty and concise git log - see gitconfig
alias gln='git lg -n 20' # above, but more logs
alias gs='git status -sb '
alias ga='git add '
alias gap='git add -p '
alias gc='git commit'
alias go='git checkout '
alias gd='git diff'

# Diff committed changes on current branch against master
alias gdm='
base=`git merge-base master HEAD`
git diff $base HEAD
'

##########################################
#
#		  RUBY
#
##########################################
alias be='bundle exec '
alias rbc='bundle exec rubocop -a'

##########################################
#
#		  FZF
#
##########################################
# FZF is a general-purpose fuzzy-finder.

# GENERAL CONFIGURATION

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='--height 50% --border=rounded --color=bg+:#3c3836,bg:#282828,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fabd2f,hl+:#fb4934'
fi

# bat (cat replacement) - use gruvbox dark theme
export BAT_THEME="gruvbox-dark"

# GIT FUNCTIONS

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

# Useful fuzzy git branch function. Aliased above.
# This and example below taken from: https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

# Extremely useful fuzzy git checkout function. Aliased above.
fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}

##########################################
#
#       CONFIGURING EXECUTABLES
#
##########################################

# zoxide: smarter cd (replaces z). `z foo` jumps to best match, `zi` opens fuzzy picker.
eval "$(zoxide init zsh)"

# eza: modern ls replacement
alias ls='eza --icons'                          # default ls with icons
alias ll='eza -la --icons --git'                # long list with git status
alias lt='eza --tree --icons --git-ignore'      # tree view (respects .gitignore)

# mise: polyglot version manager for Ruby, Node, etc. Config: ~/.config/mise/config.toml
eval "$(mise activate zsh)"

# make git english
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

##########################################
#
#           TMUX DEV LAYOUT
#
##########################################
# Opens a tmux session with nvim left, claude right, terminal bottom.
# Usage: dev          → session named after current directory
#        dev myapp    → session named "myapp"
dev() {
  local session="${1:-$(basename "$PWD" | tr '.' '_' | tr ' ' '_')}"

  if tmux has-session -t "=$session" 2>/dev/null; then
    tmux attach-session -t "=$session"
    return
  fi

  tmux new-session -d -s "$session"

  # Capture the initial pane id so we can target panes by id (not fragile index)
  local main_pane
  main_pane=$(tmux display-message -t "$session" -p "#{pane_id}")

  # Split off a full-width bottom terminal (4% height)
  local bottom_pane
  bottom_pane=$(tmux split-window -v -p 4 -t "$main_pane" -P -F "#{pane_id}")

  # Split the top pane: nvim left, claude right
  local right_pane
  right_pane=$(tmux split-window -h -p 50 -t "$main_pane" -P -F "#{pane_id}")

  tmux send-keys -t "$main_pane" "nvim ." C-m
  tmux send-keys -t "$right_pane" "claude" C-m

  # Start focused on the bottom terminal
  tmux select-pane -t "$bottom_pane"

  tmux attach-session -t "=$session"
}

##########################################
#
#           STARSHIP PROMPT
#
##########################################
# Config: ~/.config/starship.toml
eval "$(starship init zsh)"
