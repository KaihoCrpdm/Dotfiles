#!/bin/zsh

echo -e "\033[34m<-------------- Set Symlink START -------------->\033[0m"

# Configuration source directory
SOURCE="$Dotfiles_Dir/apps"

# Symbolic link mapping table
declare -A SYMLINK_MAP=(
    ["$SOURCE/zsh/zshrc"]="$HOME/.zshrc"
    ["$SOURCE/git/gitconf_mac"]="$HOME/.gitconfig"
    ["$SOURCE/nvim"]="$HOME/.config/nvim"
    ["$SOURCE/wezterm"]="$HOME/.config/wezterm"
)

# Create target directory if it doesn't exist
create_target_dir() {
    local target_dir=$1
    if [[ ! -d $target_dir ]]; then
        echo -e "\033[32m==>\033[0m Directory does not exist, creating: $target_dir"
        mkdir -p $target_dir
    fi
}

# Function to create symbolic links
create_symlink() {
    local source_file=$1
    local target_file=$2

    # If the parent directory of the target file does not exist, create it
    target_dir=$(dirname "$target_file")
    create_target_dir "$target_dir"

    # If the target file already exists, backup the old file
    if [[ -e $target_file ]]; then
        echo -e "\033[32m==>\033[0m Backing up $target_file to ${target_file}.bak"
        mv $target_file "${target_file}.bak"
    fi

    # Create the symbolic link
    echo -e "\033[32m==>\033[0m Creating symbolic link: $source_file -> $target_file"
    ln -s $source_file $target_file
}

# Iterate through the mapping table and create symbolic links
for source_file in ${(k)SYMLINK_MAP}; do
    target_file="${SYMLINK_MAP[$source_file]}"
    create_symlink $source_file $target_file
done

echo -e "\033[34m<-------------- Set Symlink EDN -------------->\033[0m"
