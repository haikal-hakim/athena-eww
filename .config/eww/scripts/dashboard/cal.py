import calendar
import json
import sys
from datetime import date

today = date.today()

year = int(sys.argv[1]) if len(sys.argv) > 1 else today.year
month = int(sys.argv[2]) if len(sys.argv) > 2 else today.month

if month > 12:
    month = 1
    year += 1
elif month < 1:
    month = 12
    year -= 1

cal = calendar.monthcalendar(year, month)
weeks = []
for week in cal:
    days = []
    for day in week:
        is_today = day == today.day and month == today.month and year == today.year
        days.append({"day": day, "today": is_today})
    weeks.append(days)

print(
    json.dumps(
        {
            "month_year": date(year, month, 1).strftime("%B %Y"),
            "weeks": weeks,
            "year": year,
            "month": month,
        }
    )
)
