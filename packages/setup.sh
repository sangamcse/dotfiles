#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

COMMENT=\#*

sudo -v

if ! [ -x "$(command -v brew)" ]; then
    info "Installing Homebrew..."
    export HOMEBREW_NO_INSTALL_FROM_API=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    success "Finished installing Homebrew."
fi

info "Installing Brewfile packages..."
brew bundle
success "Finished installing Brewfile packages."

fnm use 14
success "Switched to Node v14"

gem install cocoapods
success "Finished installing Cocoapods."

find * -name "*.list" | while read fn; do
    cmd="${fn%.*}"
    set -- $cmd
    info "Installing $1 packages..."
    while read package; do
        if [[ $package == $COMMENT ]];
        then continue
        fi
        substep_info "Installing $package..."
        $cmd $package
    done < "$fn"
    success "Finished installing $1 packages."
done

info "Installing latex dependencies..."
sudo tlmgr update --self
sudo tlmgr install latexmk
success "latex dependecies installation completed."

chsh -s $(which zsh)
