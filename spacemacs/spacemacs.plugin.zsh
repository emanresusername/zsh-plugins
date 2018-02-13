local spacemacs_dir="$HOME/.emacs.d"
test -d "$spacemacs_dir" || \
  git clone --branch=develop https://github.com/syl20bnr/spacemacs "$spacemacs_dir"
