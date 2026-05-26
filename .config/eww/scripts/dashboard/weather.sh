#!/bin/bash
DATA=$(curl -s "wttr.in/Cisomang+Barat?format=j1")

if [ -z "$DATA" ]; then
  echo '{"location": "Offline", "temp": "0", "desc": "Unknown", "type": "day"}'
  exit
fi

echo "$DATA" | python3 -c "
import json, sys
from datetime import datetime
try:
    d = json.load(sys.stdin)
    c = d['current_condition'][0]
    area = d['nearest_area'][0]['areaName'][0]['value'].title().strip()
    hour = datetime.now().hour
    weather_type = 'night' if hour >= 18 or hour < 6 else 'day'
    desc = c['weatherDesc'][0]['value'].title().strip()
    
    output = {
        'location': area,
        'temp': c['temp_C'],
        'desc': desc,
        'type': weather_type
    }
    print(json.dumps(output))
except Exception:
    print(json.dumps({'location': 'Unknown', 'temp': '0', 'desc': 'Unknown', 'type': 'day'}))
"
