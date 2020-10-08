eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_SCALE_FACTOR_ROUNDING_POLICY=PassThrough
export QT_ENABLE_HIGHDPI_SCALING=1
xrdb -merge ~/.Xresources
exec i3
