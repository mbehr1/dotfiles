#!/bin/bash

# check for zsh being installed:
command_exists() {
	command -v "$@" >/dev/null 2>&1
}

if ! command_exists zsh; then
		echo "Zsh is not installed. Please install zsh first."
		exit 1
fi

# install oh-my-zsh to default folder if not there yet:
if [ -d ~/.oh-my-zsh ]; then
    echo "oh-my-sh exists already. skipping install"
else 
    echo Install oh-my-zsh to default folder:
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# install powerlevel10k plugin/theme if not there yet:
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    echo "powerlevel10k already installed. skipping install"
else
    echo Install powerlevel10k plugin/theme
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

# create symlinks to new config files:

if [ -L ~/.zshrc ]; then
    echo ".zshrc is already a symlink. skipping install"
else
    # backup .zshrc
    echo "creating backup of current .zshrc"
    mv -iv ~/.zshrc ~/.zshrc.org_dotfiles_setup

    echo "creating symlink to .zshrc"
    ln -snv "$PWD/.zshrc" ~/.zshrc
fi

if [ -L ~/.p10k.zsh ]; then
    echo ".p10k.zsh is already a symlink. skipping install"
else
    # backup
    echo "creating backup of current .p10k.zsh"
    mv -iv ~/.p10k.zsh ~/.p10k.zsh.org_dotfiles_setup

    echo "creating symlink to .p10k.zsh"
    ln -snv "$PWD/.p10k.zsh" ~/.p10k.zsh
fi

echo "done :-)"

