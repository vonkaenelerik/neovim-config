cd ~/dotfiles

stow -t ~ git
stow -t ~ nvim
stow -t ~ zsh
stow -t ~ i3
stow -t ~ aerospace

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    stow -t ~ linux/X11
elif [[ "$OSTYPE" == "darwin"* ]]; then
    stow -t ~ macos/brew
fi
