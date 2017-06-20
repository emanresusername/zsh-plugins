export ELECTRON_CHROME=$HOME/electron-chrome
export PATH=$PATH:$ELECTRON_CHROME/node_modules/.bin

function upstall-electron-chrome(){
    git clone https://github.com/koush/electron-chrome.git $ELECTRON_CHROME
    cd  $ELECTRON_CHROME
    git fetch
    git pull origin master
    npm install
    cd -
}

function launch-chromestore-app() {
    if ! type electron &> /dev/null; then
        upstall-electron-chrome
    fi
    local app_id=$1
    electron --enable-logging $ELECTRON_CHROME --app-id=$app_id
}

function electron-chrome-vysor() {
    launch-chromestore-app gidgenkbbabolejbgbpnhbimgjbffefm
}
function electron-chrome-authy() {
    launch-chromestore-app gaedmjdfmmahhbjefcbgaolhhanlaolb
}
function electron-chrome-signal() {
    launch-chromestore-app bikioccmkafdpakkkcpdbppfkghcmihk
}
