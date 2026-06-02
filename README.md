<h1 align="center">Athena Elkowars Wacky Widgets</h1>
<p align="center">
    <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white" />
  <img src="https://img.shields.io/badge/Hyprland-33CCEE?style=flat-square&logo=hyprland&logoColor=white" />
  <img src="https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white" />
  <br />
    <a href="https://github.com/haikal-hakim/athena-eww/stargazers">
    <img src="https://img.shields.io/github/stars/haikal-hakim/athena-eww?style=flat-square&color=yellow&logo=github" />
  </a>
  <img src="https://img.shields.io/github/last-commit/haikal-hakim/athena-eww?style=flat-square&color=purple&logo=github" />
  <img src="https://img.shields.io/badge/dynamic/json?color=blue&label=Clone&query=count&url=https://gist.githubusercontent.com/haikal-hakim/10a07e69ca0835e5557794011b24b771/raw/clone.json&logo=github&style=flat-square" />
  <br />
  <a href="https://github.com/haikal-hakim/athena-eww/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-orange.svg?style=flat-square" />
  </a>
    <img src="https://img.shields.io/badge/Status-WIP-red?style=flat-square" />
</p>


---

## About Repository

My personal Eww configuration tailored for the Athena setup.

This project is still a work in progress, so some parts might still be a bit messy. Thanks for understanding!

---

## Preview

<img width="2880" height="1800" alt="eww-priview" src="https://github.com/user-attachments/assets/21b4ecd8-873a-4efe-83ab-2135226495f5" />

https://github.com/user-attachments/assets/ac15f448-8339-403a-bb59-688ef2c30191

---

## Rofi Preview

This Rofi display

| Rofi Launcher | Clipboard Manager |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/2c04699c-4ff1-49a7-9bbd-1548b23314fd" /> | <img src="https://github.com/user-attachments/assets/1a959cae-91a0-42e2-80d2-c75659826cc0" /> |
 
---

Here is the folder structure of the eww configuration (`athena-eww`):

```directory
athena-eww/
└── .config/
    ├── dunst/
    ├── fastfetch/
    ├── rofi/
    └── eww/                 # Main
        ├── assets/          # Images & icons
        ├── eww.scss
        ├── eww.yuck
        ├── scripts/         # Backend data scripts
        │   ├── bar/
        │   └── dashboard/   < toggle_dashboard.sh is here
        ├── src/             # .yuck
        │   ├── bar/
        │   ├── corner/
        │   ├── dashboard/
        │   └── panel/
        └── styles/          # .scss
            ├── bar/
            ├── corner/
            ├── dashboard/
            ├── panel/
            ├── _index.scss  # Main import styles
            └── tokens.scss  # Style variables
```

---

## Dependencies

<details>
  <summary><b>Click to see dependencies</b></summary>

To ensure all features of the Athena Eww setup work correctly, make sure the following packages are installed on your system:

| Dependency | Purpose |
| :--- | :--- |
| **`dunst`** | Notifications daemon. |
| **`jq`** | JSON processor, for weather data and system info. |
| **`curl`** | Used to fetch weather data from OpenWeatherMap API. |
| **`socat`** | Required for workspace. |
| **`python`** | Required for helper scripts. |
| **`python-psutil`** | Required for stats system info. |
| **`libnotify`** | Needed for desktop notifications. |
| **`lm_sensors`** | Linux monitoring temperature for system info. |
| **`inotify-tools`** | Required for real-time file monitoring. |
| **`networkmanager`** | Provides `nmcli` to handle Wi-Fi. |
| **`hyprshutdown`** | power menu protection for exit hyprland. |
| **`power-profiles-daemon`** | Manages system power profiles. |

### Installation (Arch Linux)
You can install the required packages using `pacman`:

```bash
sudo pacman -S dunst jq curl socat python python-psutil libnotify lm_sensors inotify-tools networkmanager hyprshutdown power-profiles-daemon
```

</details>

---

> [!IMPORTANT]
> All scripts located in the scripts/ directory require execution permissions. Before running the widgets, ensure you have applied the necessary permissions:

```bash
chmod +x ~/.config/eww/scripts/bar/*.sh
chmod +x ~/.config/eww/scripts/corner/*.sh
chmod +x ~/.config/eww/scripts/dashboard/*.sh
chmod +x ~/.config/eww/scripts/panel/*.sh
```

---

<h1 align="center">Bar Features</h1>

### Interactive

| Module | Action | Command |
| :--- | :--- | :--- |
| **`Distro Icon`** | Click | `show dashboard` |
| **`Notifications`** | Click | `dunstctl history-pop` |
| | Right-Click | `dunstctl history-clear && dunstctl close-all` |
| **`Panel Trigger`** | Click | `show panel` |

---

<h1 align="center">Panel Features</h1>

### Interactive Controls

| Module | Action | Command / Function |
| :--- | :--- | :--- |
| **`Wi-Fi`** | Click (Icon) | Toggles Wi-Fi status via `nmcli` |
| | Click (Row) | Opens `nmtui` inside terminal |
| **`Power Mode`** | Click | Cycles profiles via `powerprofilesctl` |
| **`Bluetooth`** | Click (icon) | Toggles Bluetooth adapter status |
| | Click (Row) | Opens `blueman-manager` |
| **`Do Not Disturb`** | Click | Toggles Dunst notifications status |
| **`Screenshot`** | Click | Runs local script `~/.config/hypr/scripts/screenshot.sh` |
| **`Screen Record`** | Click | Runs local script `~/.config/hypr/scripts/record.sh` |

> [!TIP]
> The **Screenshot** and **Screen Record** features are tied to my custom Hyprland scripts. If you use different tools (like `grimblast` or `wf-recorder`), adjust the script paths directly inside `eww/src/panel/quicktoggle.yuck`.

---

<h1 align="center">Dashboard Features</h1>

### Configuration Weather Location

1. **Get an API Key**: Sign up at [OpenWeatherMap](https://openweathermap.org/) and generate a free API key from your account dashboard.
2. **Find Your Coordinates**: Find the latitude (`LAT`) and longitude (`LON`) for your location (you can use Google Maps or any coordinate finder tool).

Open the weather script in your setup:

```text
eww/scripts/corner/weather.py
```

Edit your coordinates and API Key inside the script:

```Bash
API_KEY="YOUR_API_KEY"
LAT="YOUR_LATITUDE"
LON="YOUR_LONGITUDE"
```

### Customizing Folder Shortcuts

To change the folder path and file manager customization for `widget_folders`, edit `eww/src/dashboard/folders.yuck`. Find that section and update the `cmd` directive:

**Example:**

```lisp
:cmd "thunar ~/Documents &"
```

### Configuration Note

The Todo widget requires a local text file to function. Ensure the following path exists:

- **Path:** `~/Documents/todo.txt`
- **Format:** A simple text file containing your tasks (maximum 2 lines).

Example content:
```text
Task one
Task two
```

---

<h1 align="center">Autostart & Keybindings</h1>

### Autostart

You need to launch the Eww daemon and open the window inside your Window Manager configuration.
Example:

```text
exec-once = eww daemon
exec-once = sleep 2 && eww open window_bar
exec-once = sleep 3 && eww open window_weather
exec-once = sleep 4 && eww open window_clock
exec-once = sleep 5 && eww open window_launcher
exec-once = sleep 20 && eww open window_power
```

### Keybindings

To toggle the dashboard, map the execution script to your Window Manager configuration.

>Manual Testing
>You can test the toggle script directly from your terminal by running:

```bash
bash ~/.config/eww/scripts/dashboard/toggle_dashboard.sh
```

### Example (Hyprland)

Add the following to your `hyprland.conf`:

```text
bind = $mainMod, SPACE, exec, ~/.config/eww/scripts/dashboard/toggle_dashboard.sh
```

### Multimedia Keys

To enable the OSD volume and brightness buttons on your keyboard, add this to `hyprland.conf`. Example:

```text
bindel = ,XF86AudioRaiseVolume, exec, bash ~/.config/eww/scripts/corner/osd_vol.sh vol-up
bindel = ,XF86AudioLowerVolume, exec, bash ~/.config/eww/scripts/corner/osd_vol.sh vol-down
bindel = ,XF86MonBrightnessUp, exec, bash ~/.config/eww/scripts/corner/osd_bright.sh bright-up
bindel = ,XF86MonBrightnessDown, exec, bash ~/.config/eww/scripts/corner/osd_bright.sh bright-down
```

---

## Acknowledgments

* **[Eww](https://github.com/elkowar/eww)** - Created by **Elkowar**. Huge thanks to the creator and contributors for this amazing widget ecosystem.
* Also thanks to everyone whose open source configurations were inspiring.

### Epilogue

This configuration is the basis of freedom. Use it as a basis, or take only the parts that are useful.

> "Freedom is when a person obeys his own conscience, not what other people say."

*Muhammad Haikal Hakim*
