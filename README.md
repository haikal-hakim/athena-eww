<h1 align="center">Athena Elkowars Wacky Widgets</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white" />
  <img src="https://img.shields.io/badge/Hyprland-33CCEE?style=flat-square&logo=hyprland&logoColor=white" />
  <img src="https://img.shields.io/badge/Status-WIP-red?style=flat-square" />
  <br />
  <img src="https://img.shields.io/github/last-commit/haikal-hakim/athena-eww?style=flat-square&color=purple&logo=github" />
  <img src="https://img.shields.io/badge/dynamic/json?color=blue&label=Clone&query=count&url=https://gist.githubusercontent.com/haikal-hakim/10a07e69ca0835e5557794011b24b771/raw/clone.json&logo=github&style=flat-square" />
  <br />
  <a href="https://github.com/haikal-hakim/athena-eww/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-orange.svg?style=flat-square" />
  </a>
</p>

<p align="center">
  My personal Eww (Elkowar's Wacky Widgets) ecosystem for the Athena setup.
</p>

---

## About Repository

This repo is actually just for fun, coding, creating layouts, and other things. Maybe I'll add something new, like a bar, in the future.

This project is still under development, therefore please forgive if this structure is not neat. Thanks.

---


## Resolution & Positioning

This config is optimized for **2880x1800 (HiDPI)** screens. Since this setup uses absolute coordinates.

> [!TIP]
> You will need to adjust the geometry values in `X` and `Y` in `eww/src/dashboard/dashboard.yuck`.

---

## Preview

<img width="2880" height="1800" alt="20260525_231808" src="https://github.com/user-attachments/assets/e00b8376-b724-40e5-94ff-0cdd6491fa41" />

---

## Rofi Preview
This Rofi display,

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
    └── eww/                 # Main widget ecosystem
        ├── assets/          # Images & icons
        ├── eww.scss
        ├── eww.yuck
        ├── scripts/         # Backend data scripts
        │   ├── bar/
        │   └── dashboard/   < toggle_dashboard.sh is here
        ├── src/             # .yuck
        │   ├── bar/
        │   └── dashboard/
        └── styles/          # .scss
            ├── bar/
            ├── dashboard/
            ├── _index.scss  # Main import styles
            └── tokens.scss  # Style variables
```

---

## Dependencies

To ensure all features of the Athena Eww setup work correctly, make sure the following packages are installed on your system:

| Dependency | Purpose |
| :--- | :--- |
| **`dunst`** | Notifications daemon. |
| **`jq`** | JSON processor, for weather data and system info. |
| **`curl`** | Used to fetch weather data from `wttr.in`. |
| **`socat`** | Required for workspace. |
| **`python`** | Required for helper scripts. |
| **`libnotify`** | Needed for desktop notifications. |
| **`lm_sensors`** | Linux monitoring temperature for system info. |
| **`inotify-tools`** | Required for real-time file monitoring. |
| **`networkmanager`** | Provides `nmcli` to handle Wi-Fi |
| **`power-profiles-daemon`** | Manages system power profiles. |

### Installation (Arch Linux)
You can install the required packages using `pacman`:

```bash
sudo pacman -S dunst jq curl socat python libnotify lm_sensors inotify-tools networkmanager power-profiles-daemon
```

---

> [!IMPORTANT]
> All scripts located in the scripts/ directory require execution permissions. Before running the widgets, ensure you have applied the necessary permissions:

```bash
chmod +x ~/.config/eww/scripts/bar/*.sh
chmod +x ~/.config/eww/scripts/dashboard/*.sh
```

---

<h1 align="center">Bar Features</h1>

## Interactive

| Module | Action | Command |
| :--- | :--- | :--- |
| **`Notifications`** | Click | `dunstctl history-pop` |
| | Right-Click | `dunstctl history-clear && dunstctl close-all` |
| **`Network`** | Click | `show nmcli` |

---

<h1 align="center">Dashboard Features</h1>

## Customizing profile

Put the photo into the `eww/assets` folder and change the photo, name and tags, open:

```
eww/src/dashboard/profile.yuck
```

Edit the code:

```lisp
:style "background-image: url('${EWW_CONFIG_DIR}/assets/NAME_FILE.png'); border-radius: 99px;"
```

---

## Configuration Weather Location

The weather widget fetches data from wttr.in. To change the location, open:

```text
eww/scripts/dashboard/weather.sh
```

Edit the curl URL:

```Bash
DATA=$(curl -s "wttr.in/YOUR_CITY?format=j1")
```

---

## Customizing Folder Shortcuts

To change the folder path and file manager customization for `widget_folders`, edit `eww/src/dashboard/folders.yuck`. Find that section and update the `cmd` directive:

**Example:**

```lisp
:cmd "thunar ~/Documents &"
```

---

## Configuration Note

The Todo widget requires a local text file to function. Ensure the following path exists:

- **Path:** `~/Documents/todo.txt`
- **Format:** A simple text file containing your tasks (maximum 3 lines).

Example content:
```text
Task one
Task two
Task three
```

---

<h1 align="center">Autostart & Keybindings</h1>

## Launch Bar

You need to launch the Eww daemon and open the bar window inside your Window Manager configuration.

```text
exec-once = eww daemon && eww open window_bar
```

---

## Keybindings

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

---
