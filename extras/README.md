# Eww Magic Variable Battery

Config default eww I actually use a script for the battery. If you're allergic to using script, there's an alternative battery widget using the default `EWW_BATTERY`.

### Advantages

- No polling scripts
- Less shell overhead
- Simpler setup

### Disadvantages

- No battery notifications
- No remaining time estimation
- Depends on Eww battery support

---

# Setup

The provided `extras/battery.yuck` file uses `BAT0` by default.
Your system may use a different battery key.

Check your battery information:

```bash
eww get EWW_BATTERY
```

Example output:

```text
{"BAT0":{"capacity":75,"status":"Charging"}}
```

If your battery key is not `BAT0`, open:

```text
extras/battery.yuck
```

Replace `BAT0` with your own battery key:

```lisp
EWW_BATTERY["BAT0"].status == 'Charging' ? 'charging' :
```

---

Then replace:

```text
.config/eww/bar/src/battery.yuck
```

with:

```text
extras/battery.yuck
```

No SCSS changes are required because both versions use the same widget classes.

You can safely remove or keep the original `scripts/battery.sh` file if it is no longer used.
