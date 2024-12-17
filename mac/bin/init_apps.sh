#!/bin/zsh

echo -e "\033[34m[-------------- Install apps START -------------->\033[0m"

if ! command -v brew &>/dev/null; then
    echo -e "\033[31mERROR\033[0m: homebrew is not installed. Please run [ setup_homebrew.sh] first."
    exit 1
fi

apps=(
    # Format: "Description:Installation Command"
    "[fd]:brew install fd"
    "[nvm]:brew install nvm"
    "[fzf]:brew install fzf"
    "[qq]:brew install --cask qq"
    "[neovim]:brew install neovim"
    "[lazygit]:brew install lazygit"
    "[ripgrep]: brew install ripgrep"
    "[wechat]:brew install --cask wechat"
    "[qqmusic]:brew install --cask qqmusic"
    "[wezterm]:brew install --cask wezterm"
    "[vscode]:brew install --cask visual-studio-code"
    "[font]:brew install --cask font-maple-mono"
    "[font]:brew install --cask font-jetbrains-mono-nerd-font"
)

# Function to install apps
install_apps() {
    for app in "${apps[@]}"; do
        description=${app%%:*}
        command=${app#*:}

        echo -e "\033[32m==>\033[0m Checking if $description is installed..."

        # Check if the application is already installed using brew
        if [[ $command == *"brew install"* ]]; then
            app_name=$(echo -e $command | cut -d ' ' -f 3) # Extract the app name from the install command

            if brew list --formula | grep -q "^$app_name\$" || brew list --cask | grep -q "^$app_name\$"; then
                echo -e "\033[32m==>\033[0m $description is already installed. Skipping..."
            else
                echo -e "\033[32m==>\033[0m Installing $description..."
                eval $command

                if [[ $? -eq 0 ]]; then
                    echo -e "\033[32m==>\033[0m $description installed successfully!"
                else
                    echo -e "\033[31mERROR\033[0m: Failed to install $description."
                    return 1 # Return error if installation fails
                fi
            fi
        else
            echo -e "\033[31mERROR\033[0m: $description installation command is not recognized. Skipping..."
            return 1 # Return error if command is not recognized
        fi
    done
    return 0 # All installations successful
}

# Loop until all apps are installed
until install_apps; do
    echo -e "\033[31mERROR\033[0m: Some apps failed to install. Retrying..."
    echo -e "\033[34m[-------------- Install apps RESTART -------------->\033[0m"
    echo -e "\033[33mPress Enter to retry...\033[0m"
    read -r
done

echo -e "\033[34m[-------------- Install apps END -------------->\033[0m"
