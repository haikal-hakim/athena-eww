#!/usr/bin/env python3
import json
import glob
import psutil


def get_temp():
    temp = 0
    temps = psutil.sensors_temperatures()
    for chip in ["coretemp", "k10temp", "tctl", "acpitz", "zenpower", "amdgpu"]:
        if chip in temps and temps[chip]:
            temp = int(temps[chip][0].current)
            break

    if temp == 0:
        try:
            priority = ["x86_pkg_temp", "tcpu", "cpu", "soc", "pkg"]
            found = {}
            for zone in glob.glob("/sys/class/thermal/thermal_zone*/temp"):
                zone_type = zone.replace("temp", "type")
                try:
                    with open(zone_type) as f:
                        ztype = f.read().strip().lower()
                    with open(zone) as f:
                        t = int(f.read().strip()) / 1000
                    if 0 < t < 120:
                        found[ztype] = int(t)
                except Exception:
                    continue
            for key in priority:
                for ztype, t in found.items():
                    if key in ztype:
                        temp = t
                        break
                if temp > 0:
                    break
        except Exception:
            temp = 0

    return json.dumps({"temp": temp})


if __name__ == "__main__":
    print(get_temp())
