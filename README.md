# Hey! I'm Jonathan :wave:

This is my collection of dotfiles. Feel free to browse and borrow anything you like ("borrowing" is how most of this config ended up here anyway :grin:).

It's useful for me to have my dotfiles under source control, so that they are: backed up, versioned and shareable between multiple computers.

## Philosophy

For a long time, my Dotfiles were messy terra incognita: a hodgepodge of uncommented commands and settings that I'd stolen from blogs. This meant that my tools felt scary and triggered some emotional aversion. I didn't feel in control of them.

For Vim in particular, I made the mistake of adding too many plugins and too many commands that I only half-understood.

In general, I want my tools (especially my daily tools, like my editor - Neovim - and the command line) to bring me joy :grin:.

So in 2022, I made the following resolutions about my Dotfiles:
- Don't add a line without understanding what it does and why I need it
- Add a descriptive comment to every line in every dotfile
	- This ensures both that I'll remember in the future, but also that I *understand it right now*

## Contents (in order of importance)

- `init.vim` configuration for my primary editor, neovim
- `Brewfile` important packages
- `zshrc` [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) stuff
- `gitconfig` the prettier git log alias is the most interesting thing in here
- `doomd` the first [editor](https://github.com/hlissner/doom-emacs) I ever loved :heart:

## Simplified instructions for adding a new dotfile (because I always forget)

- To add a new file/folder:
  - Move (don't copy) the file/folder into `~/.dotfiles`
  - Remove the preceding `.` from its name
  - Add the name to the `link` block in `install.conf.yaml`
  - Run `./install`

## Brand new Mac fresh install steps

TODO: Turn this into an automatic install script.

Basics:
- Sane defaults for Mac system preferences: https://sourabhbajaj.com/mac-setup/SystemPreferences/
- `xcode-select --install` install xcode
- `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"` install homebrew
- [Generate SSH keys](https://docs.github.com/en/github/authenticating-to-github/checking-for-existing-ssh-keys)

These Dotfiles:
- `git clone git@github.com:jnsya/dotfiles.git` clone this repo
- `cd ~/dotfiles && ./install` add these dotfiles
- `brew bundle` installs every package and cask from the Brewfile
- `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` install oh-my-zsh
- `rm ~/.zshrc` then `./install` again to ensure that this repo's version of `zshrc` has not been overwritten by the oh-my-zsh default
- install syntax highlighting plugin: `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`
- `source ~/.zshrc`
- `(brew --prefix)/opt/fzf/install` enable fuzzy completion with fzf

Install Doom
```
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
export PATH=$PATH:~/.emacs.d/bin
```

## Thanks

This is a fork of [Dotbot](https://github.com/anishathalye/dotbot).
