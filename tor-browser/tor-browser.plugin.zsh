VERSION="7.0.5"
ARCHIVE="tor-browser-linux64-${VERSION}_en-US.tar.xz"
SIG="$ARCHIVE.asc"
ARCHIVE_URL="https://www.torproject.org/dist/torbrowser/$VERSION/$ARCHIVE"
SIG_URL="$ARCHIVE_URL.asc"
export TOR_BROWSER_HOME="$HOME/tor-browser"

function tor-browser-install() {
    mkdir -p "$TOR_BROWSER_HOME"
    local archive="$TOR_BROWSER_HOME/$ARCHIVE"
    local sig="$TOR_BROWSER_HOME/$SIG"
    curl -L "$ARCHIVE_URL" > "$archive"
    curl -L "$SIG_URL" > "$sig"
    gpg --keyserver pool.sks-keyservers.net --recv-keys 0x4E2C6E8793298290
    gpg --verify $sig $archive
    tar -xvJf $archive -C "$TOR_BROWSER_HOME" --strip-components=1
    rm $sig $archive
}

function tor-browser() {
    local launcher="$TOR_BROWSER_HOME/start-tor-browser.desktop"
    if [ ! -x "$launcher" ]
    then
        tor-browser-install
    fi
    cd $TOR_BROWSER_HOME
    "$launcher" "$@"
    cd -
}
