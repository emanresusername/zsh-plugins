export NWJS_VERSION=${NWJS_VERSION:-0.24.3}
export NWJS_CHROME_VERSION=${NWJS_CHROME_VERSION:-60.0.3112.90}
export NWJS_HOME=${NWJS_HOME:-$HOME/nwjs/$NWJS_VERSION}
export NWJS_BIN=$NWJS_HOME/bin
export NWJS_APP=$NWJS_HOME/app/$NWJS_CHROME_VERSION

function nwjs-install() {
    echo "fetching nwjs v:$NWJS_VERSION"
    mkdir -p $NWJS_BIN

    local url="https://dl.nwjs.io/v$NWJS_VERSION/nwjs-v$NWJS_VERSION-linux-x64.tar.gz"
    curl -s "$url" | tar -C $NWJS_BIN --strip-components=1 -xzf -
}

function nwjs-app-dir() {
    local app_id=$1
    echo $NWJS_APP/$app_id
}

function nwjs-install-app() {
    local app_id=$1
    echo "fetching crx file for app: $app_id"
    mkdir -p $NWJS_APP
    local url="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=$NWJS_CHROME_VERSION&x=id%3D$app_id%26uc"
    local crx="/tmp/$app_id.crx"
    curl -Ls "$url" -o "$crx"
    unzip "$crx" -d "`nwjs-app-dir $app_id`"
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
