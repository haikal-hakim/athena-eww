<h1 align="center">Athena Elkowars Wacky Widgets</h1>

<p align="center">
  <a href="https://github.com/haikal-hakim/atheneww/blob/main/LICENSE">
   <img src="https://img.shields.io/github/license/haikal-hakim/atheneww?style=flat&color=orange&cacheSeconds=0" />
  </a>
  <img src="https://img.shields.io/badge/Status-WIP-red?style=flat" />
</p>

<p align="center">
  My personal Eww (Elkowar's Wacky Widgets) ecosystem for the Athena setup.
</p>

---

## About This Project
This repository is my personal ecosystem for **Eww (Elkowar's Wacky Widgets)**, specifically crafted for my **Athena** setup.

---

## Preview

<img width="2880" height="1800" alt="20260521_165926" src="https://github.com/user-attachments/assets/a5ae1cd0-e5dd-4452-b387-84457dd7fd2d" />

---

This repository is structured to maintain a clean separation between **logic** (scripts), **structure** (Yuck markup), and **style** (SCSS tokens), ensuring that the dashboard remains modular, maintainable, and easily extendable for future iterations.

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

> [!IMPORTANT]
> The Todo widget requires a local text file to function. Ensure the following path exists:

- **Path:** `~/Documents/file.txt`
- **Format:** A simple text file containing your tasks (maximum 3 lines).

Example content:
```text
Task one
Task two
Task three
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
