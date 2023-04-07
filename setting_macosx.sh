#!/usr/bin/env zsh
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $DIR


# install homebrew
if [ -z "$(brew --version | grep Homebrew)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install brew cask
brew update
brew install tmux pyenv pyenv-virtualenv git wget glib cmake vim

# pyenv init
if ! which pyenv-virtualenv-init > /dev/null; then
    export PATH="~/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# oh-my-tmux
if [ ! -d "$HOME/.tmux" ]; then
    cd
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
fi

# ultimate-vimrc
if [ ! -d "$HOME/.vim_runtime" ]; then
    git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
    sh $HOME/.vim_runtime/install_awesome_vimrc.sh
fi

# git config
git config --global user.name "Jungmin Kong"
git config --global user.email jungmin.knog@navercorp.com
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
