export ZSH="$HOME/devlove/dotfiles/zsh/oh-my-zsh"

export TERM="xterm-256color"

ZSH_THEME="zeit"

ZSH_AUTOSUGGEST_USE_ASYNC=true

plugins=(
    git osx jsontools
)

#Locale setting for python iterm2
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

DISABLE_UPDATE_PROMPT=true

source $ZSH/oh-my-zsh.sh

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export DYLD_LIBRARY_PATH="$(brew --prefix openssl)/lib:$DYLD_LIBRARY_PATH"
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CPPFLAGS="-I$(brew --prefix openssl)/include"
export PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig"
export PKG_CONFIG_PATH="$(brew --prefix imagemagick@6)/lib/pkgconfig"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(rbenv init - zsh)"
eval "$(fnm env)"

export GPG_TTY=$(tty)

alias dotfiles="cd ~/devlove/dotfiles"

export PATH="/Library/TeX/texbin/:$PATH"

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
