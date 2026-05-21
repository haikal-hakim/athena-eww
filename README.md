<h1 align="center">Athena Elkowars Wacky Widgets</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=arch-linux&logoColor=white" />
  <img src="https://img.shields.io/badge/Python-FFD43B?style=flat-square&logo=python&logoColor=black" />
  <img src="https://img.shields.io/badge/Shell_Script-121011?style=flat&logo=gnu-bash&logoColor=white" />
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

This repository is structured to maintain a clean separation between **logic** (scripts), **structure** (Yuck markup), and **style** (SCSS tokens), ensuring that the dashboard remains modular, maintainable, and easily extendable for future iterations.

---

## Preview

<img width="2880" height="1800" alt="20260521_165926" src="https://github.com/user-attachments/assets/a5ae1cd0-e5dd-4452-b387-84457dd7fd2d" />

---

## Project Structure

```text
atheneww/
└── eww/
    ├── assets/          # Icons, images, and visual assets
    ├── scripts/         # Bash & Python scripts for data
    ├── src/             # .yuck files
    ├── tokens/          # .scss styles
    ├── eww.scss         # Main stylesheet entry
    └── eww.yuck         # Main configuration entry
```

---

> [!IMPORTANT]
> All scripts located in the scripts/ directory require execution permissions. Before running the widgets, ensure you have applied the necessary permissions:

```bash
chmod +x ~/.config/eww/scripts/*.sh
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

## Configuration Weather Location

The weather widget fetches data from wttr.in. To change the location, open:

```text
eww/scripts/weather.sh
```

Edit the curl URL:

```Bash
DATA=$(curl -s "wttr.in/YOUR_CITY?format=j1")
```

---

## Customizing Folder Shortcuts

To change the folder path and file manager customization for `widget_folders`, edit `eww/src/folders.yuck`. Find that section and update the `onclick` directive:

**Example:**

  ```lisp
  :onclick "bash ~/.config/eww/scripts/toggle_dashboard.sh close && thunar ~/Downloads &"
  ```

---

## Keybindings

The dashboard can be toggled using the provided script in the scripts/ directory. Map the following command to your window manager's configuration:

```bash
~/.config/eww/scripts/toggle_dashboard.sh
```

### Example (Hyprland)

Add the following to your `hyprland.conf`:

```text
bind = $mainMod, SPACE, exec, ~/.config/eww/scripts/toggle_dashboard.sh
```

---

## Dependencies

To ensure all features of the Athena Eww setup work correctly, make sure the following packages are installed on your system:

| Dependency | Purpose |
| :--- | :--- |
| **`inotify-tools`** | Required for real-time file monitoring. |
| **`jq`** | JSON processor, used to parse weather data and system info. |
| **`curl`** | Used to fetch weather data from `wttr.in`. |
| **`python`** | Required for helper scripts. |
| **`libnotify`** | Needed for desktop notifications. |

### Installation (Arch Linux)
You can install the required packages using `pacman`:

```bash
sudo pacman -S inotify-tools jq curl python libnotify
```

---
