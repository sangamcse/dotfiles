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
eval "$(fnm env --multi)"

export GPG_TTY=$(tty)

DOTFILES="$HOME/devlove/dotfiles"
alias dotfiles="cd $DOTFILES"
export PATH="$DOTFILES/scripts:$PATH"

export PATH="/Library/TeX/texbin/:$PATH"
export PATH="$HOME/Library/Android/sdk/tools:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="/Library/TeX/texbin/:$PATH"

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

export GOPATH=$HOME/work/
export PATH=$GOPATH/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

alias k='kubectl'
alias kx='kubectx'
alias ka='kubectl get pods'
alias kaw='kubectl get pods -o wide'


_qx() {
    AWS_PROFILE=hr-dev aws eks update-kubeconfig --name qa
    sleep 5
    kubectx hr-qa
    local POD=$(kubectl get pods -n qatest | grep hrw-web-rails | awk 'FNR==1{print $1}')
    kubectl exec -it $POD -n qatest -c rails bash
}

_px() {
    kubectx hr-private
    local NAMESPACE="${2:-rba}"
    local POD=$(kubectl get pods -n $NAMESPACE | grep hrw-web-rails | awk 'FNR==1{print $1}')
    kubectl exec -it $POD -n $NAMESPACE -c rails bash
}
