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
- `tmux.conf` — tmux config (mouse, true colour, vi copy mode)
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

Use mise for all language versions (Ruby, Node, Python, etc). See [mise section](#mise-language-versions) below.

```bash
mise use --global ruby@latest
mise use --global node@lts
```

## Tool reference

Quick cheatsheet for tools I always forget:

```
zoxide:   zi          fuzzy-pick from history

lazygit:  lg          open TUI
                      space=stage  enter=hunk-stage  c=commit  r=rebase  ?=help

tmux:     dev         open dev layout (nvim left | claude right, terminal bottom)
          dev myapp   same but with a named session (re-running re-attaches)

          Ctrl+b [    enter scroll/copy mode (vi keys to move, q to exit)
          Ctrl+b z    zoom current pane to fullscreen (again to unzoom)
          Ctrl+b →←↑↓ move between panes
          Ctrl+b d    detach session (keep it running in background)
          tmux ls     list running sessions
          tmux a      re-attach to last session
```

### Scrolling in tmux panes

Keyboard: `Ctrl+b [` enters copy mode. Use `Ctrl+u`/`Ctrl+d` to scroll half-page, or arrow keys. `q` to exit.

Mouse: scroll wheel works, but TUI apps (like Claude Code) capture mouse events. Hold **`Shift`** while scrolling to bypass the app and let tmux scroll instead.

## mise — language versions

[mise](https://mise.jdx.dev/) is the one tool that manages versions of Ruby, Node, Python, and anything else. Don't use rbenv, nvm, pyenv, or asdf — mise replaces all of them.

### How it works

mise reads a config file in each project directory and automatically activates the right version when you `cd` in. No manual switching needed.

It understands the old version files too, so existing projects just work:
- `.ruby-version` (rbenv format) ✓
- `.tool-versions` (asdf format) ✓
- `.mise.toml` (native format) ✓

### Setting a version for a project

```bash
cd my-project

mise install        # if the project already has a .ruby-version or .tool-versions file
                    # this installs whatever version it specifies

mise use ruby@3.4   # if there's no file yet — installs 3.4 and writes a .mise.toml
```

### Other useful commands

```bash
mise current              # what versions are active right now?
mise ls                   # all installed versions
mise use --global ruby@3.4   # change your global default
mise use --global node@lts
```

### Adding a new language

```bash
mise use --global python@3.12   # installs and sets as global default
```

That's it. Same pattern for every language.

## Thanks

This repo is managed with [Dotbot](https://github.com/anishathalye/dotbot).
