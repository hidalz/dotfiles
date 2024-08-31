# Set zsh as the default shell if not already
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Changing default shell to zsh..."
  chsh -s /bin/zsh
fi

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install all Brew packages from Brewfile
echo "Installing Brew packages..."
brew bundle --file=./Brewfile

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k theme if not installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Clone and apply dotfiles using chezmoi
echo "Setting up dotfiles using chezmoi..."
chezmoi init --apply https://github.com/hidalz/dotfiles

echo "Setup complete!"