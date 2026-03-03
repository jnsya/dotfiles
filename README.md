# Hey! I'm Jonathan :wave:

This is my collection of dotfiles. Feel free to browse and borrow anything you like ("borrowing" is how most of this config ended up here anyway :grin:).

It's useful for me to have my dotfiles under source control, so that they are: backed up, versioned and shareable between multiple computers.

## Philosophy

I want my tools (especially my daily tools, like my editor and the command line) to bring me joy. So:
- Don't add a line without understanding what it does and why I need it
- Add a descriptive comment to every line in every dotfile

## Contents

- `nvim/` — [LazyVim](https://www.lazyvim.org/) config
- `zshrc` — Zsh + [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) config
- `starship.toml` — Shell prompt ([Starship](https://starship.rs/))
- `lazygit.yml` — [Lazygit](https://github.com/jesseduffield/lazygit) TUI config
- `gitconfig` — Git aliases and settings
- `Brewfile` — All packages and apps
- `gruvbox-dark.itermcolors` — iTerm2 colour preset

## Adding a new dotfile

- Move (don't copy) the file/folder into `~/dotfiles`
- Remove the preceding `.` from its name
- Add the name to the `link` block in `install.conf.yaml`
- Run `./install`

## Fresh Mac install

For a fully automated install, run `./setup.sh` after cloning. The steps below explain what it does.

### 1. Prerequisites

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

[Generate SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and add to GitHub.

### 2. Clone and symlink dotfiles

```bash
git clone git@github.com:jnsya/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install
```

### 3. Install packages

```bash
brew bundle
```

### 4. Oh My Zsh + plugins

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# If oh-my-zsh overwrote ~/.zshrc, restore the symlink:
rm ~/.zshrc && cd ~/dotfiles && ./install

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/Aloxaf/fzf-tab \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

$(brew --prefix)/opt/fzf/install

source ~/.zshrc
```

### 5. iTerm2 (manual — can't be scripted)

- **Font:** Preferences → Profiles → Text → set font to `FiraCode Nerd Font Mono`
- **Colours:** Preferences → Profiles → Colors → Color Presets → Import → select `~/dotfiles/gruvbox-dark.itermcolors`, then choose `gruvbox-dark`

### 6. Neovim

Open `nvim` — LazyVim auto-installs all plugins on first launch.

### 7. Languages

```bash
# Ruby
rbenv install <version> && rbenv global <version>

# Node
nvm install --lts
```

## Tool reference

Quick cheatsheet for tools I always forget:

```
zoxide:   z <name>    jump to best match
          zi          fuzzy-pick from history

lazygit:  lg          open TUI
                      space=stage  enter=hunk-stage  c=commit  r=rebase  ?=help

eza:      ls          ls with icons
          ll          long list with git status
          lt          tree view

bat:      bat <file>  syntax-highlighted cat
```

## Thanks

This repo is managed with [Dotbot](https://github.com/anishathalye/dotbot).
