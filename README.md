# polybar-interface-switch

This polybar module shows the IP address of a specific network interface. Also allows you to change the selected interface with right-click and copy the IP address to the clipboard with left-click. It's very useful in CTF games when you have to constantly copy your IP address for a reverse shell.

![](media/demo.gif)

## Usage

- **Left Click:** Copy the IPv4 address of the previously selected network interface.
- **Right Click:** Launch Rofi menu to select a new network interface.

## Dependencies

- **iproute2:** To list the available network interfaces and their associated IP addresses.
```bash
 # If for an incredible reason you don't have this indispensable network tool installed
 $ apt install iproute2 -y
```
- **xclip:** To copy the IP address to clipboard.

```bash
 # Install xclip from apt
 $ apt install xclip -y
```
## Setup

- Make sure to go through the config variables in [interface\_switch.sh](interface_switch.sh), [copy\_ip.sh](copy_ip.sh) and [show\_ip.sh](show_ip.sh). They should be pointing to their corresponding configuration files.
```sh
# interface_switch.sh
SDIR="$HOME/.config/polybar/scripts"
CONFIG_FILE="$SDIR/interface.conf"    # Store the selected network interface
STYLES_FILE="$SDIR/interface.rasi"    # Styles for rofi menu

# copy_ip.sh
CONFIG_FILE="$HOME/.config/polybar/scripts/interface.conf"

# show_ip.sh
CONFIG_FILE="$HOME/.config/polybar/scripts/interface.conf"
```

- Add the following code in your polybar config.
```ini
[module/interface_switch]
type = custom/script

format-background = ${color.alt-bg}
format-foreground = ${color.green}
format-padding = 2

interval = 90
exec = ~/.config/polybar/scripts/show_ip.sh
click-left = ~/.config/polybar/scripts/copy_ip.sh &
click-right = ~/.config/polybar/scripts/interface_switch.sh &
```
