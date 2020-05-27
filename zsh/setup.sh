#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

sudo -v

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~)"
OHMYZSH_PATH="$SOURCE/oh-my-zsh"

info "Installing OHMYZSH"
git clone https://github.com/ohmyzsh/ohmyzsh.git "$OHMYZSH_PATH"
ZSH="$OHMYZSH_PATH" sh "$OHMYZSH_PATH/tools/install.sh"

curl https://raw.githubusercontent.com/zeit/zsh-theme/master/vercel.zsh-theme -Lo "$OHMYZSH_PATH/custom/themes/zeit.zsh-theme"

info "Configuraing zsh..."

find . -name ".zsh*" | while read fn; do
    fn=$(basename $fn)
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

success "Finished configuring zsh."
