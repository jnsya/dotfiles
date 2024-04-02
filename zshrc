# Note: Run `source ~/.zshrc` to reload this file after making changes

##########################################
#
#		OH-MY-ZSH
#
##########################################
# Note: Plugins and Theme need to be loaded BEFORE sourcing the oh-my-zsh config file, or stuff breaks.
# Theme
ZSH_THEME="robbyrussell"
# Plugins
# Note: new plugins should be installed at `~/.oh-my-zsh/custom/plugins`, then added to this list.
plugins=(
zsh-syntax-highlighting
fzf-tab # Add functions which use fzf to fuzzy search. eg: fzf-kill to select a process to kill.
zsh-vi-mode # Better, more vimlike vim mode
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
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

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
#           	DOOM EMACS
#
##########################################
export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
export PATH=~/.emacs.d/bin:$PATH


##########################################
#
#           	LATANA
#
##########################################
# Switches to the correct context using 'kubectl ctx [staging|production]
# Runs kubectl get pods using the currect directory to get the namespace
# Usage: `kubessh <ENV> <SUBENV>`
#
#   Example: 
#     if you're inside LatanaMetrics dir and run
#       $ kubessh staging web
#     it will be equivilent to
#       $ kubectl -n latanametrics-staging exec -it <SOME-POD> bash
kubessh () {
  environment=$1
  subenv=$2
  working_dir=${PWD##*/}
  project=$(echo "$working_dir" | tr '[:upper:]' '[:lower:]' )
  namespace="$project-$environment"

  context=$(kubectx | grep "$environment")
  kubectx $context

  output=$(kubectl -n "$namespace" get pods | grep "$subenv" | head -n 1)
  podname=${output%% *}; remainder="${remainder#* }"

  echo "ssh-ing you into $podname. . ."

  kubectl -n $namespace exec -it $podname bash
}
##########################################
#
#       CONFIGURING EXECUTABLES
#
##########################################

# Config for the z executable. This line is suggested by `brew info z`.
. `brew --prefix`/etc/profile.d/z.sh

# One executable I needed was installed in sbin, so I added it to PATH
export PATH="/usr/local/sbin:$PATH"

# Sets up rbenv's shims path, among other things. See https://github.com/rbenv/rbenv#how-rbenv-hooks-into-your-shell
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

##########################################
#
#           BOILERPLATE
#
##########################################

# The following commented lines all came automatically with the original zshrc.
# They might contain useful stuff so I won't delete them.


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="/usr/local/opt/node@16/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
