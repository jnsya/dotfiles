#!/usr/bin/env bash
# Run this on a fresh Mac after cloning the dotfiles repo.
# Usage: cd ~/dotfiles && ./setup.sh

set -e

DOTFILES="$HOME/dotfiles"

echo "==> Installing dotbot symlinks..."
cd "$DOTFILES" && ./install

echo "==> Installing Homebrew packages..."
brew bundle

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  # oh-my-zsh overwrites ~/.zshrc — restore our symlink
  rm -f "$HOME/.zshrc"
  cd "$DOTFILES" && ./install
else
  echo "    Oh My Zsh already installed, skipping."
fi

echo "==> Installing zsh-syntax-highlighting plugin..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
  echo "    zsh-syntax-highlighting already installed, skipping."
fi

echo "==> Installing fzf-tab plugin..."
if [ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]; then
  git clone https://github.com/Aloxaf/fzf-tab \
    "$ZSH_CUSTOM/plugins/fzf-tab"
else
  echo "    fzf-tab already installed, skipping."
fi

echo "==> Installing fzf shell integration..."
"$(brew --prefix)/opt/fzf/install" --all --no-bash --no-fish

echo ""
echo "============================================"
echo "  Almost done! Complete these manual steps:"
echo "============================================"
echo ""
echo "iTerm2 font:"
echo "  Preferences → Profiles → Text"
echo "  Set font to: FiraCode Nerd Font Mono"
echo ""
echo "iTerm2 colours:"
echo "  Preferences → Profiles → Colors → Color Presets → Import"
echo "  Select: ~/dotfiles/gruvbox-dark.itermcolors"
echo "  Then choose gruvbox-dark from the list"
echo ""
echo "Neovim:"
echo "  Run 'nvim' — LazyVim will auto-install all plugins on first launch"
echo ""
echo "Ruby (when needed):"
echo "  rbenv install <version> && rbenv global <version>"
echo ""
echo "Node (when needed):"
echo "  nvm install --lts"
echo ""
echo "Then run: source ~/.zshrc"
echo ""
echo "Done!"
