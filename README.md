<h1 align="center">Athena Elkowars Wacky Widgets</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white" />
  <img src="https://img.shields.io/badge/Python-FFD43B?style=flat-square&logo=python&logoColor=black" />
  <img src="https://img.shields.io/badge/Shell_Script-121011?style=flat&logo=gnu-bash&logoColor=white" />
  <br />
  <img src="https://img.shields.io/github/last-commit/haikal-hakim/athena-eww?style=flat-square&color=purple&logo=github" />
  <img src="https://img.shields.io/badge/dynamic/json?color=blue&label=Clone&query=count&url=https://gist.githubusercontent.com/haikal-hakim/10a07e69ca0835e5557794011b24b771/raw/clone.json&logo=github&style=flat-square" />
  <br />
  <a href="https://github.com/haikal-hakim/athena-eww/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-orange.svg?style=flat-square" />
  </a>
  <img src="https://img.shields.io/badge/Status-WIP-red?style=flat-square" />
</p>

<p align="center">
  My personal Eww (Elkowar's Wacky Widgets) ecosystem for the Athena setup.
</p>

---

## About Repository

This repo is actually just for fun, coding, creating layouts, and other things. Maybe I'll add something new, like a bar, in the future.

This project is still under development, therefore please forgive if this structure is not neat. Thanks.

---

## Preview

<img width="2880" height="1800" alt="20260525_102925" src="https://github.com/user-attachments/assets/a6db0291-0cf7-4d01-9cde-637136efaad5" />

---

## Project Structure

Here is the folder structure of the Eww configuration (`athena-eww`):

```folder
athena-eww/
├── assets/                  # Images
├── scripts/                 # Backend script
│   ├── bar/
│   └── dashboard/           < File toggle_dashboard.sh in here
│
├── src/                     # Source code .yuck
│   ├── bar/                 # Top Bar
│   │   ├── bar.yuck         # Layouts& include widget bar
│   │   └── [widgets].yuck
│   └── dashboard/           # Widget Dashboard
│       ├── dashboard.yuck   # Layouts & include widget dashboard
│       └── [widgets].yuck
│
├── styles/                  # Styling .scss
│   ├── bar/
│   ├── dashboard/
│   ├── _index.scss          # Main import styles
│   └── tokens.scss          # Variables
│
├── eww.scss                 # Entry point stylesheet
└── eww.yuck                 # Entry point window
```

---

## Dependencies

To ensure all features of the Athena Eww setup work correctly, make sure the following packages are installed on your system:

| Dependency | Purpose |
| :--- | :--- |
| **`inotify-tools`** | Required for real-time file monitoring. |
| **`jq`** | JSON processor, used to parse weather data and system info. |
| **`curl`** | Used to fetch weather data from `wttr.in`. |
| **`libnotify`** | Needed for desktop notifications. |
| **`lm_sensors`** | Linux monitoring temperature for system info. |
| **`socat`** | Required for workspace. |
| **`python`** | Required for helper scripts. |

### Installation (Arch Linux)
You can install the required packages using `pacman`:

```bash
sudo pacman -S inotify-tools jq curl libnotify lm_sensors socat python
```

---

> [!IMPORTANT]
> All scripts located in the scripts/ directory require execution permissions. Before running the widgets, ensure you have applied the necessary permissions:

```bash
chmod +x ~/.config/eww/scripts/bar/*.sh
chmod +x ~/.config/eww/scripts/dashboard/*.sh
```

---

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
