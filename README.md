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

My personal Eww configuration tailored for the Athena.

This project is still a work in progress, so some parts might still be a bit messy. Thanks for understanding!

---

## Preview

<img src="https://github.com/user-attachments/assets/a8d019df-6909-4e9e-9801-f6994b5e02aa" /> <img src="https://github.com/user-attachments/assets/982cc07f-043e-4050-a1d3-c529204cb0dc" /> <img src="https://github.com/user-attachments/assets/908757bb-3d11-4ee9-af46-e5416faf97fc" />


https://github.com/user-attachments/assets/0954f470-4e62-480a-9cf7-3b219e3ee9f1

---

## Rofi Preview

This Rofi display

| Rofi Launcher | Clipboard Manager |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/2c04699c-4ff1-49a7-9bbd-1548b23314fd" /> | <img src="https://github.com/user-attachments/assets/1a959cae-91a0-42e2-80d2-c75659826cc0" /> |
 
---

Here is the folder structure configuration:

```directory
athena-eww/
└── .config/
    ├── dunst/
    ├── eww
    │   ├── assets/
    │   ├── eww.scss
    │   ├── eww.yuck
    │   ├── bar/
    │   ├── corner/
    │   ├── dashboard/
    │   ├── panel/
    │   └── theme/
    │       ├── manifest.scss
    │       └── tokens.scss
    ├── fastfetch/
    └── rofi/
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
| **`libnotify`** | Needed for desktop notifications. |
| **`inotify-tools`** | Required for real-time file monitoring. |
| **`networkmanager`** | Provides `nmcli` to handle Wi-Fi. |
| **`hyprshutdown`** | power menu protection for exit hyprland. |
| **`power-profiles-daemon`** | Manages system power profiles. |

### Installation (Arch Linux)
You can install the required packages using `pacman`:

```bash
sudo pacman -S dunst jq curl socat python libnotify inotify-tools networkmanager hyprshutdown power-profiles-daemon
```

</details>

---

> [!IMPORTANT]
> All scripts located in the scripts/ directory require execution permissions. Before running the widgets, ensure you have applied the necessary permissions:

```bash
chmod +x ~/.config/eww/bar/scripts/*.sh
chmod +x ~/.config/eww/corner/scripts/*.sh
chmod +x ~/.config/eww/dashboard/scripts/*.sh
chmod +x ~/.config/eww/panel/scripts/*.sh
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
| **`System Theme`** | Click | Change theme variant Mocha, Latte, Night and Light|

> [!TIP]
> The **Screenshot** and **Screen Record** features are tied to my custom Hyprland scripts. Paths directly inside `eww/panel/src/quicktoggle.yuck`.

---

<h1 align="center">Configuration & Customization</h1>

### Weather Location

**Get an API Key**: Sign up at [OpenWeatherMap](https://openweathermap.org/) generate a API key from your account. Find your location.

Open the weather script:

```text
eww/dashboard/scripts/weather.py
```

Edit your coordinates and API Key inside the script:

```Bash
API_KEY="YOUR_API_KEY"
CITY="YOUR_CITY"
```

### Hardware Temperature

This setting uses Eww's built-in [Magic Variables](https://elkowar.github.io/eww/magic-vars.html), not external scripts.

By default, configured with **`CORETEMP_PACKAGE_ID_0`** because my device uses an Intel CPU. Your device may have different hardware.
1. Find your actual CPU temperature key by running this command in your terminal:

```bash
eww get EWW_TEMPS
```

2. Look at the output, find your `main/package temperature sensor name`, and update it inside `eww/dashboard/src/sysinfo.yuck`:

```lips
(circular-progress :value {((EWW_TEMPS["YOUR_SESOR_KEY"] ?: EWW_TEMPS["Tdie"] ?: 0) / 100) * 100}
                   :class "sysinfo-temp"
                   :thickness 6
                   :width 90
                   :height 90
                   (stack :selected {open_temp ? 1 : 0}
                          :transition "slideleft"
                          (label :class "sysinfo-icon-temp"
                                 :text "")
                                 (label :class "sysinfo-stat"
                                        :text "${EWW_TEMPS["YOUR_SESOR_KEY"] ?: EWW_TEMPS["Tdie"] ?: 0}°C")
                   )
)
```

### Configuration Note

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

### Autostart

You need to launch the Eww daemon and open the window inside your Window Manager configuration.
Example `Hyprland`:

```lua
hl.exec_cmd("eww daemon")
hl.exec_cmd("sleep 2 && eww open window_bar")
hl.exec_cmd("sleep 3 && eww open window_website")
hl.exec_cmd("sleep 4 && eww open window_launcher")
hl.exec_cmd("sleep 5 && eww open window_power")
```

### Keybindings

To toggle the dashboard, map the execution script to your Window Manager configuration.

>Manual Testing
>You can test the toggle script directly from your terminal by running:

```bash
bash ~/.config/eww/dashboard/scripts/toggle_dashboard.sh
```

### Example (Hyprland)

Add the following to your `hyprland.lua`:

```lua
hl.bind(mainMod .. " + D", function()
	hl.dispatch(hl.dsp.exec_cmd(home .. "/.config/eww/dashboard/scripts/toggle_dashboard.sh"))
end)
```

### Multimedia Keys

To enable the OSD volume and brightness buttons on your keyboard, add this to `hyprland.lua`. Example:

```lua
-- Volume --
hl.bind("XF86AudioRaiseVolume", function()
	hl.dispatch(hl.dsp.exec_cmd("bash " .. home .. "/.config/eww/corner/scripts/osd_vol.sh vol-up"))
end, { repeating = true })

hl.bind("XF86AudioLowerVolume", function()
	hl.dispatch(hl.dsp.exec_cmd("bash " .. home .. "/.config/eww/corner/scripts/osd_vol.sh vol-down"))
end, { repeating = true })

-- Brightness --
hl.bind("XF86MonBrightnessUp", function()
	hl.dispatch(hl.dsp.exec_cmd("bash " .. home .. "/.config/eww/corner/scripts/osd_bright.sh bright-up"))
end, { repeating = true })

hl.bind("XF86MonBrightnessDown", function()
	hl.dispatch(hl.dsp.exec_cmd("bash " .. home .. "/.config/eww/corner/scripts/osd_bright.sh bright-down"))
end, { repeating = true })
```

---

## Acknowledgments

* **[Eww](https://github.com/elkowar/eww)** - Created by **Elkowar**. Huge thanks to the creator and contributors for this amazing widget ecosystem.
* Also thanks to everyone whose open source configurations were inspiring.

### Epilogue

This configuration is the basis of freedom. Use it as a basis, or take only the parts that are useful.

> "Freedom is when a person obeys his own conscience, not what other people say."

*Muhammad Haikal Hakim*
