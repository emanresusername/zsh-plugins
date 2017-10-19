export NWJS_HOME=${NWJS_HOME:-$HOME/nwjs}
export NWJS_VERSION=${NWJS_VERSION:-0.26.0}
export NWJS_BIN=$NWJS_HOME/bin/$NWJS_VERSION

function nwjs-chrome-version() {
    nwjs --version | cut -d' ' -f2
}

function nwjs-app-dir() {
    local app_id=$1
    echo "$NWJS_HOME/app/$app_id"
}

function nwjs-install() {
    echo "fetching nwjs v:$NWJS_VERSION"
    mkdir -p $NWJS_BIN

    local url="https://dl.nwjs.io/v$NWJS_VERSION/nwjs-sdk-v$NWJS_VERSION-linux-x64.tar.gz"
    curl -s "$url" | tar -C $NWJS_BIN --strip-components=1 -xzf -
}

function nwjs-app-crx-url() {
    local app_id=$1
    echo "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=`nwjs-chrome-version`&x=id%3D$app_id%26uc"
}

function nwjs-install-app() {
    local app_id=$1
    echo "fetching crx file for app: $app_id"
    local url="`nwjs-app-crx-url $app_id`"
    local crx="`mktemp --suffix=.crx`"
    curl -Ls "$url" -o "$crx"
    local app_dir="`nwjs-app-dir $app_id`"
    mkdir -p "$app_dir"
    unzip "$crx" -d "$app_dir"
    rm "$crx"
}

function nwjs() {
    local nw=$NWJS_BIN/nw
    if [ ! -x "$nw" ]
    then
        nwjs-install
    fi
    $nw "$@"
}

function nwjs-run-app() {
    local app_id=$1
    local app_dir="`nwjs-app-dir $app_id`"
    if [ ! -d "$app_dir" ]; then
        nwjs-install-app $app_id
    fi
    nwjs "$app_dir"
}

# TODO: switch off electron-chrome when this works
function nwjs-vysor() {
    nwjs-run-app gidgenkbbabolejbgbpnhbimgjbffefm
}
function nwjs-authy() {
    nwjs-run-app gaedmjdfmmahhbjefcbgaolhhanlaolb
}
function nwjs-signal() {
    nwjs-run-app bikioccmkafdpakkkcpdbppfkghcmihk
}
