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

## Thanks

This is a fork of [Dotbot](https://github.com/anishathalye/dotbot).
