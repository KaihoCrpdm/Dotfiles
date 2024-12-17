#!/bin/zsh
echo -e "\033[34m<-------------- Mac Setup START -------------->\033[0m"

# Export Dotfiles absolute path as Dotfiles_Dir
Current_Dir=$(dirname "$(realpath "$0")")
export Dotfiles_Dir=$(dirname "$Current_Dir")

# Set Proxy
export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897

# Add running permissions for the scripts
for script in "$Current_Dir/bin/"*.sh; do
	chmod +x "$script"
done

"$Current_Dir/Script/setup_homebrew.sh"
# Configure the environment when Homebrew installation is complete
eval "$(/opt/homebrew/bin/brew shellenv)"

"$Current_Dir/bin/setup_ohmyzsh.sh"

"$Current_Dir/bin/setup_symlink.sh"

"$Current_Dir/bin/init_apps.sh"

echo -e "\033[34m<-------------- Mac Setup END -------------->\033[0m"
