# Automatic Light/Dark Mode Switcher

## What does this script do?

This is an automatic theme switcher for Ubuntu 22.04+.

It uses `gsettings` to set your preferred light and dark themes at the configured times. It also sets the prefer-light/prefer-dark value to indicate to programs and websites which mode you prefer.

Optionally, `notify-send` is called to display a notification when the mode has been changed successfully.

## Installation

1. Open the `auto-darkmode-switcher.sh` script with a text editor.
2. Set the start times for each mode, the themes you want to switch to and, optionally, enable notifications (default: enabled).
3. In a terminal, execute the install script once: `sh ./install.sh`. This will set up a systemd service and timer for your user.

## Troubleshooting

Execute `systemctl --user list-timers`. If all went well, there should be a `auto-darkmode-switcher.time`-unit in the list. Exit by pressing <kbd>q</kbd>.

If necessary, you can directly edit the systemd service's configuration file with `systemctl edit --user auto-darkmode-switcher.service`. Note: The installation script will overwrite your changes if you re-run it.

## How to stop the script

Execute `systemctl --user stop auto-darkmode-switcher.timer`.

Follow the installation instructions if you want to start it again.

## License

This code is supplied under an [MIT License](LICENSE).