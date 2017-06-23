local CONF="$HOME/.config/youtube-dl/config"
mkdir -p $(dirname $CONF)
cat > $CONF <<EOF
--external-downloader aria2c
--external-downloader-args "-c -j 5 -x 3 -s 3 -k 1M"
EOF
