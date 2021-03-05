# Hey! I'm Jonathan :wave:

This is my collection of dotfiles. Feel free to browse and borrow anything you like ("borrowing" is how most of this config ended up here anyway :grin:).

It's useful for me to have my dotfiles under source control, so that they are: backed up, versioned and shareable between multiple computers.

## Contents

- `doomd` the first [editor](https://github.com/hlissner/doom-emacs) I've ever loved :heart:
- `gitconfig` the prettier git log alias is the most interesting thing in here
- `vimrc` my vim setup, though Doom is my primary editor nowadays
- `zshrc` [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) stuff
- `Brewfile` important packages

## Simplified instructions (because I always forget)

- To add a new file/folder:
  - Move (don't copy) the file/folder into `~/.dotfiles`
  - Remove the preceding `.` from its name
  - Add the name to the `link` block in `install.conf.yaml`
  - Run `./install`

## Brand new Mac fresh install steps
Basics:
- `xcode-select --install` install xcode
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"` install homebrew
- [Generate SSH keys](https://docs.github.com/en/github/authenticating-to-github/checking-for-existing-ssh-keys)

Dotfiles:
- `git clone git@github.com:jnsya/dotfiles.git` clone this repo
- `cd ~/dotfiles && ./install` add these dotfiles
- `brew bundle` installs every package and cask from the Brewfile
- `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` install oh-my-zsh
- ensure that this repo's version of `zshrc` has not been overwritten by the oh-my-zsh default
- install syntax highlighting plugin: `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- `source ~/.zshrc`
- `/usr/local/opt/fzf/install` enable fuzzy completion with fzf

Install Doom
```
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
export PATH=$PATH:~/.emacs.d/bin
```

## Thanks

This is a fork of [Dotbot](https://github.com/anishathalye/dotbot).
