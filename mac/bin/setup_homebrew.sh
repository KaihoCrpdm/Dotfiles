#!/bin/zsh

echo -e "\033[34m<-------------- Update homebrew START -------------->\033[0m"

if command -v brew >/dev/null 2>&1; then
	echo -e "\033[32m==>\033[0m Homebrew is already installed"
	echo -e "\033[32m==>\033[0m Updating..."
	brew update && brew upgrade
	echo -e "\033[32m==>\033[0m Homebrew has been updated!"
else
	echo -e "\033[32m==>\033[0m Homebrew is not installed"
	echo -e "\033[32m==>\033[0m Installing now..."
	until brew install; do
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		eval "$(/opt/homebrew/bin/brew shellenv)"
		if command -v brew >/dev/null 2>&1; then
			echo -e "\033[32m==>\033[0m Homebrew installation completed!"
			break
		else
			echo -e "\033[32m==>\033[0m Homebrew installation failed, retrying..."
			echo -e "\033[34m<-------------- Update homebrew RESTART -------------->\033[0m"
			echo -e "\033[33mPress Enter to retry...\033[0m"
			read -r
		fi
	done
fi

if command -v brew >/dev/null 2>&1; then
	echo -e "\033[32m==>\033[0m Homebrew is ready to use."
else
	echo -e "\033[31mERROR\033[0m: Homebrew setup failed after multiple attempts. Please check manually."
	exit 1
fi

echo -e "\033[34m<-------------- Update homebrew END -------------->\033[0m"
