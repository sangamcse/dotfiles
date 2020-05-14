#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ../scripts/functions.sh

COMMENT=\#*
REPO_PATH=$(realpath ~/work)
RUBY_VERSION="2.6.3"

find * -name "*.list" | while read fn; do
    info "Cloning $folder repositories..."

    mkdir -p "$REPO_PATH"
    while read repo; do
        if [[ $repo == $COMMENT ]];
        then continue; else
            pushd "$REPO_PATH" &> /dev/null
            git clone $repo &> /dev/null
            if [[ $? -eq 128 ]]; then
                substep_success "$repo already exists."
            elif [[ $? -eq 0 ]]; then
                substep_success "Cloned $repo."
            else
                substep_error "Failed to clone $repo: $?."
            fi
            popd &> /dev/null
        fi
    done < "$fn"
    success "Finished cloning $folder repositories."
done

info "Setup Ruby Default to $RUBY_VERSION"
rbenv install "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"
rbenv rehash

gem install bundler
success "Setup of default Ruby is completed. "
