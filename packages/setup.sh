#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

COMMENT=\#*

sudo -v

if ! [ -x "$(command -v brew)" ]; then
    info "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    success "Finished installing Homebrew."
fi

info "Installing Brewfile packages..."
brew bundle
success "Finished installing Brewfile packages."

fnm use 10
success "Switched to Node v10"

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
