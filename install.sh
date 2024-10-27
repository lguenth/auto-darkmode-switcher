#!/bin/bash

echo "Making auto-darkmode-switcher-script executable…"
THEME_SWITCHER_SCRIPT=$(pwd)/auto-darkmode-switcher.sh
chmod +x "$THEME_SWITCHER_SCRIPT"

echo "Creating startup-service…"

systemctl edit --user --force --full auto-darkmode-switcher.service --stdin <<END
[Unit]
Description=Auto Light/Dark Mode Switcher

[Service]
ExecStart="$THEME_SWITCHER_SCRIPT"

[Install]
WantedBy=default.target
END

echo "Starting auto-darkmode-switcher…"

systemctl enable --user auto-darkmode-switcher.service

# Execute script once to kick it off
/bin/bash "$THEME_SWITCHER_SCRIPT"

echo "Installation done."
echo "Light and dark mode will now be set at the times configured."
