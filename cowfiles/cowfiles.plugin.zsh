local cowfiles="$(dirname $0)"
# TODO: should submodule handling be responsibility of framework or plugin?
local paulkaefer_cowfiles=$cowfiles/paulkaefer
git clone https://github.com/paulkaefer/cowsay-files.git $paulkaefer_cowfiles
export COWPATH="${COWPATH:+"$COWPATH:"}$paulkaefer_cowfiles/cows"

if (( $+commands[brew] )); then
    local brew_cowfiles="$(brew --prefix)/share/cows"
    if [ -d "$brew_cowfiles" ]; then
        export COWPATH=$COWPATH:"$brew_cowfiles"
    fi
fi
