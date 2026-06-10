<h1 align="center">Athena Elkowars Wacky Widgets</h1>
<p align="center">

<div align=center>

![Arch Linux](https://img.shields.io/badge/Arch_Linux-11111b?style=for-the-badge&logo=arch-linux&logoColor=89b4fa)
![Hyprland](https://img.shields.io/badge/Hyprland-11111b?style=for-the-badge&logo=hyprland&logoColor=89dceb)
![GitHub Repo stars](https://img.shields.io/github/stars/haikal-hakim/athena-eww?style=for-the-badge&logo=github&labelColor=11111b&color=cba6f7)
![GitHub Clones](https://img.shields.io/badge/dynamic/json?style=for-the-badge&label=CLONES&query=count&url=https://gist.githubusercontent.com/haikal-hakim/10a07e69ca0835e5557794011b24b771/raw/clone.json&logo=github&labelColor=11111b&color=89dceb)
<a href="https://github.com/haikal-hakim/athena-eww/blob/main/LICENSE">
  <img src="https://img.shields.io/github/license/haikal-hakim/athena-eww?style=for-the-badge&labelColor=11111b&color=f38ba8" />
</a>

</div>

---

## Preview

<img src="https://github.com/user-attachments/assets/982cc07f-043e-4050-a1d3-c529204cb0dc" /> <img src="https://github.com/user-attachments/assets/908757bb-3d11-4ee9-af46-e5416faf97fc" />


https://github.com/user-attachments/assets/0954f470-4e62-480a-9cf7-3b219e3ee9f1

---

## Rofi Preview

| Rofi Launcher | Clipboard Manager |
| :---: | :---: |
| <img src="https://github.com/user-attachments/assets/2c04699c-4ff1-49a7-9bbd-1548b23314fd" /> | <img src="https://github.com/user-attachments/assets/1a959cae-91a0-42e2-80d2-c75659826cc0" /> |
 
---

Here is the folder structure configuration:

```directory
athena-eww/
├── .config/
│   ├── dunst/
│   ├── eww/
│   │   ├── assets/           # Icons and widget images
│   │   ├── bar/
│   │   ├── corner/
│   │   ├── dashboard/
│   │   ├── panel/
│   │   ├── theme/            # Theme state and color palettes
│   │   ├── eww.yuck
│   │   ├── eww.scss
│   │   └── toggle_theme.sh   # Switcher theme script
│   ├── fastfetch/
│   ├── kitty/
│   └── rofi/
└── .zshrc
```

---

## Dependencies

<details>
  <summary><b>Click here to see dependencies</b></summary>

To ensure all features of the Athena Eww setup work correctly, make sure the following packages are installed on your system:

| Dependency | Purpose |
| :--- | :--- |
| **`awk`** | Text processor for system output parsing.|
| **`bluez-utils`** | Bluetooth management tool (bluetoothctl). |
| **`brightnessctl`** | Backlight and brightness control. |
| **`curl`** | HTTP tool to fetch weather data API. |
| **`dunst`** | Notifications daemon. |
| **`grep`** | Global Regular Expression Print. |
| **`hyprshutdown`** | Session and power menu backend. |
| **`inotify-tools`** | Real-time file & theme change monitor. |
| **`jq`** | JSON parser for widget data. |
| **`libnotify`** | System notification dispatcher (notify-send). |
| **`networkmanager`** | Wi-Fi and network controller (nmcli). |
| **`power-profiles-daemon`** | Manages system power profiles. |
| **`python`** | Required for helper scripts. |
| **`socat`** | Real-time socket listener for Hyprland. |
| **`ttf-jetbrains-mono-nerd`** | Font.|
| **`wireplumber`** | Audio volume controller (wpctl). |
| **`Tela circle dark`** | Icon, optional dependencies.|

### Install (Arch Linux)

You can install the required packages using `pacman`:

```bash
sudo pacman -S awk bluez-utils brightnessctl curl dunst grep hyprshutdown inotify-tools jq libnotify networkmanager power-profiles-daemon python socat ttf-jetbrains-mono-nerd wireplumber
```

</details>

---

## Installation

Clone this repository:

```bash
git clone https://github.com/haikal-hakim/athena-eww.git
cd athena-eww
```

Copy configuration files:
```bash
cp -r .config/* ~/.config/
cp .zshrc ~/
```

---

<h1 align="center">Required Configuration</h1>
<p align="center">
  These settings are required for the widgets to work properly on your system.
</p>

### Script Permissions

All scripts inside the `scripts/` directories must be executable:

```bash
chmod +x ~/.config/eww/toggle_theme.sh
chmod +x ~/.config/eww/bar/scripts/*.sh
chmod +x ~/.config/eww/corner/scripts/*.sh
chmod +x ~/.config/eww/dashboard/scripts/*.sh
chmod +x ~/.config/eww/panel/scripts/*.sh
```

### Weather API (Dashboard)

Create an API key from [OpenWeatherMap](https://openweathermap.org/). Activation may take around 30 minutes.
Open the weather script:

```text
.config/eww/dashboard/scripts/weather.py
```

Set your API key and city:

```Bash
API_KEY="YOUR_API_KEY"
CITY="YOUR_CITY"
```

### Weather Forecast Scale (Dashboard)

Widget weather forecast uses a vertical progress bar that serves as a temperature graph. My local tropical climate ranges from **15°C** to **36°C**, and yours may be different.

Open file:

```text
.config/eww/dashboard/src/weather_forecast.yuck
```

Find this section:

```lisp
:value {(day.temp - MIN_TEMP) / (MAX_TEMP - MIN_TEMP) * 100}
```

### Hardware Temperature Sensor (Dashboard)

This setting uses Eww's built-in [Magic Variables](https://elkowar.github.io/eww/magic-vars.html), not external scripts.
By default, configured with **`CORETEMP_PACKAGE_ID_0`** because my device uses an Intel CPU. Your device may have different hardware.

Check your available sensors, command in your terminal:

```bash
eww get EWW_TEMPS
```

Look for your sensor key or `main packages` in the output, and update key inside:

```text
.config/eww/dashboard/src/sysinfo.yuck:
```

Find section:

```lisp
(circular-progress :value {((EWW_TEMPS["YOUR_SENSOR_KEY"] ?: EWW_TEMPS["Tdie"] ?: 0) / 100) * 100}
                      ....
                            ....
                   (label :class "sysinfo-stat"
                          :text "${EWW_TEMPS["YOUR_SENSOR_KEY"] ?: EWW_TEMPS["Tdie"] ?: 0}°C")
                   )
)
```

> [!TIP]
> An alternative `battery.yuck` using Eww built-in `magic variables` is available inside the [extras/](./extras/) folder.
> This version removes polling scripts but does not include notifications or remaining time estimation.

### Todo Widget File (Dashboard)

- **Path:** `~/Documents/todo.txt`
- **Format:** A simple text file containing your tasks (maximum 3 lines).

Example:

```text
Task one
Task two
Task three
```

---

<h1 align="center">Optional Customization</h1>
<p align="center">
  These settings are optional and purely based on personal preference.
</p>

### Themes (panel)

If you want to modify an existing theme or add your own custom color scheme, you can do so. However, to prevent config corruption, any new theme must use the exact same color variable names (such as `base`, `mantle`, `crust`, `peach`, `mauve`, etc.) as the original Catppuccin Mocha theme.

Available themes:
- Catppuccin Mocha
- Catppuccin Latte
- Tokyo Night
- Tokyo Night Light

Create a new .scss palette inside `.config/eww/theme/`, and edit:

1. scripts Actions.`config/eww/toggle_theme.sh`
2. Widget file `.config/eww/panel/src/switcher.yuck`
3. Style Customization `.config/eww/panel/styles/switcher.scss`

### Website Shortcuts (Corner)

1. Script Actions `.config/eww/corner/scripts/website.sh`
2. Widget file `.config/eww/corner/src/website.yuck`
3. Style Customization `.config/eww/corner/styles/website.scss`

### App Launcher (Corner)

1. Put new `.png` icons inside the assets directory `.config/eww/assets/apps/`
2. Modify the Apps and Commands

```text
.config/eww/corner/src/launcher.yuck.
```

Example:

```lisp
(launcher-btn :icon "${EWW_CONFIG_DIR}/assets/apps/firefox.png"
              :cmd "firefox &")
```

---

<h1 align="center">Features</h1>

### Bar

| Module | Action | Command |
| :--- | :--- | :--- |
| **`Distro Icon`** | Click | `show dashboard` |
| **`Notifications`** | Click | `dunstctl history-pop` |
| | Right-Click | `dunstctl history-clear && dunstctl close-all` |
| **`Panel Trigger`** | Click | `show panel` |

### Panel

| Module | Action | Command / Function |
| :--- | :--- | :--- |
| **`Wi-Fi`** | Click | Toggles Wi-Fi status via `nmcli` |
| | Row Click | Opens `nmtui` inside terminal |
| **`Power Mode`** | Click | Cycles profiles via `powerprofilesctl` |
| **`Bluetooth`** | Click | Toggles Bluetooth adapter status |
| | Row Click | Opens `blueman-manager` |
| **`Do Not Disturb`** | Click | Toggles Dunst notifications status |
| **`Screenshot`** | Click | Runs local script `~/.config/hypr/scripts/screenshot.sh` |
| **`Screen Record`** | Click | Runs local script `~/.config/hypr/scripts/record.sh` |
| **`System Theme`** | Click | Change the current theme variant|

> [!TIP]
> The **Screenshot** and **Screen Record** features are tied to my custom Hyprland scripts. Paths are defined inside `~/.config/eww/panel/src/quicktoggle.yuck`.

---

<h1 align="center">Autostart</h1>

Example `hyprland.lua` style:

```lua
hl.exec_cmd("eww daemon")
hl.exec_cmd("sleep 2 && eww open window_bar")
hl.exec_cmd("sleep 3 && eww open window_website")
hl.exec_cmd("sleep 4 && eww open window_launcher")
hl.exec_cmd("sleep 5 && eww open window_power")
```

---

<h1 align="center">Keybindings</h1>

Dashboard toggle:

```bash
eww open window_dashboard
```

Example `hyprland.lua` style:

```lua
hl.bind(mainMod .. " + D", function()
	hl.dispatch(hl.dsp.exec_cmd("eww close window_dashboard || eww open window_dashboard"))
end)
```

### Multimedia Control

To enable the OSD volume and brightness buttons on your keyboard. Example `hyprland.lua` style:

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

*Muhammad Haikal Hakim*
