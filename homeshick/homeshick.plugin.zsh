local homeshick_home="$HOME/.homesick/repos/homeshick"
local homeshick_init="$homeshick_home/homeshick.sh"
if [ ! -f "$homeshick_init" ] &> /dev/null; then
  git clone git://github.com/andsens/homeshick.git $homeshick_home
fi
source $homeshick_init

# (no home) sick -> not (home sick) -> home (not sick) -> home swell ᕕ( ᐛ )ᕗ
# https://github.com/andsens/homeshick/wiki/Symlinking#repos-with-no-home-directory
export HOMESHWELL="repos-with-no-home-directory"
function homeshick-ensure-homeshwell() {
  homeshick -q generate $HOMESHWELL
}
function homeshick-homeshwell-clone() {
  local user="$1"
  local repo="$2"
  local url="https://github.com/$user/$repo.git"
  local submodule="$3"
  local branch="$4"

  homeshick-ensure-homeshwell

  (
    # cd in subshell
    homeshick cd $HOMESHWELL && \
      git submodule add "$url" "home/$submodule"
    if [ -n "$branch" ]; then
      cd "$submodule" && git checkout "$branch"
    fi
  )
}
