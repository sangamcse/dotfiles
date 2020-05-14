#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~)"
OHMYZSH_PATH="$SOURCE/oh-my-zsh"

info "Installing OHMYZSH"
git clone https://github.com/ohmyzsh/ohmyzsh.git "$OHMYZSH_PATH"
ZSH="$OHMYZSH_PATH" sh "$OHMYZSH_PATH/tools/install.sh"

curl https://raw.githubusercontent.com/zeit/zeit.zsh-theme/master/zeit.zsh-theme -Lo "$OHMYZSH_PATH/custom/themes/zeit.zsh-theme"

info "Configuraing zsh..."

rm -rf "$DESTINATION/.zsh*"

find . -name ".zsh*" | while read fn; do
    fn=$(basename $fn)
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

chsh -s $(which zsh)

success "Finished configuring zsh."
