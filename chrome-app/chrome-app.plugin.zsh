export CHROME_APP_CHROME_VERSION=${CHROME_APP_CHROME_VERSION:-61.0.3163.100}

function chrome-app-id() {
    local app_url="$1"
    echo $app_url | cut -d/ -f7 | cut -d? -f1
}

function chrome-app-crx-url() {
    local app_id="$1"
    echo "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=$CHROME_APP_CHROME_VERSION&x=id%3D$app_id%26uc"
}

function chrome-app-unpacked() {
    local app_url="$1"
    local app_id=`chrome-app-id "$app_url"`
    local url="`chrome-app-crx-url "$app_id"`"
    local crx="`mktemp --suffix=.crx`"
    curl -Ls "$url" -o "$crx"
    local app_dir=$2
    mkdir -p "$app_dir"
    unzip "$crx" -d "$app_dir"
    rm "$crx"
}
