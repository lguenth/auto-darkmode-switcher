#!/bin/bash

# Set your preferred light/dark mode themes

# To see what theme/icon is currently enabled, execute this command:
# gsettings get org.gnome.desktop.interface gtk-theme
# gsettings get org.gnome.desktop.interface icon-theme

# To see available themes and icons:
# ls /usr/share/themes/
# ls /usr/share/icons/

LIGHT_GTK_THEME="Yaru"
DARK_GTK_THEME="Yaru-dark"

LIGHT_ICON_THEME="Yaru"
DARK_ICON_THEME="Yaru-dark"

# Set start times

LIGHT_START_TIME="09:30"
DARK_START_TIME="16:00"

# Optional: Set notify-send options

USE_NOTIFY_SEND=1
APP_NAME="Auto Theme Switcher"
NOTIF_TIMEOUT=3600
LIGHT_ICON="$(pwd)/icons/sun.svg"
DARK_ICON="$(pwd)/icons/moon.svg"

#
#
# DO NOT edit below this line.
# (Unless you know what you are doing.)
#
#

NOW=$(date +"%Y-%m-%d %H:%M:%S")
COMPARABLE_NOW=$(date --date="$NOW 1 second" +%Y%m%d%H%M)
COMPARABLE_LIGHT_START_TIME=$(date --date="$LIGHT_START_TIME" +%Y%m%d%H%M)
COMPARABLE_DARK_START_TIME=$(date --date="$DARK_START_TIME" +%Y%m%d%H%M)

echo "Starting light mode at: $LIGHT_START_TIME"
echo "Starting dark mode at:  $DARK_START_TIME"
echo "Current date and time: $NOW"

if [ "$COMPARABLE_NOW" -gt "$COMPARABLE_LIGHT_START_TIME" ] && [ "$COMPARABLE_NOW" -lt "$COMPARABLE_DARK_START_TIME" ]; then
    echo "Setting day theme…"

    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_GTK_THEME"
    gsettings set org.gnome.desktop.interface icon-theme "$LIGHT_ICON_THEME"

    echo "Day theme has been set"

    if [ "$USE_NOTIFY_SEND" -eq 1 ]; then
        notify-send "Light mode activated." -a "$APP_NAME" -t "$NOTIF_TIMEOUT" -i "$LIGHT_ICON"
    fi

    NEXT_EXECUTION_AT=$(date --date="$DARK_START_TIME" +"%Y-%m-%d %H:%M")
else
    echo "Setting night theme…"

    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme "$DARK_GTK_THEME"
    gsettings set org.gnome.desktop.interface icon-theme "$DARK_ICON_THEME"

    echo "Night theme has been set"

    if [ "$USE_NOTIFY_SEND" -eq 1 ]; then
        notify-send "Dark mode activated." -a "$APP_NAME" -t "$NOTIF_TIMEOUT" -i "$DARK_ICON"
    fi

    NEXT_EXECUTION_AT=$(date --date="$LIGHT_START_TIME 1 day" +"%Y-%m-%d %H:%M")
fi

# Set next execution-time of this script
echo "Next execution of the auto-darkmode-switcher-script: $NEXT_EXECUTION_AT"

# Remove an already existing timer, if one exists
systemctl --user stop auto-darkmode-switcher.timer 2>/dev/null

# Specifying a fixed "unit" avoids adding the timer again, if it exists already.
systemd-run --user --no-ask-password --on-calendar "$NEXT_EXECUTION_AT" --unit="auto-darkmode-switcher" --collect
