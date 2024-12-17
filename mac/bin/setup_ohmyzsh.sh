#!/bin/zsh

echo -e "\033[34m<-------------- Clone oh-my-zsh START -------------->\033[0m"

OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"

if [ ! -d "$OH_MY_ZSH_DIR" ]; then
	echo -e "\033[32m==>\033[0m Oh My Zsh is not installed. Cloning now..."
	git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OH_MY_ZSH_DIR"
else
	echo -e "\033[32m==>\033[0m Oh My Zsh is already installed."
fi

echo -e "\033[32m==>\033[0m Installing plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$OH_MY_ZSH_DIR/custom}/plugins/zsh-syntax-highlighting

echo -e "\033[34m<-------------- Clone oh-my-zsh END -------------->\033[0m"
