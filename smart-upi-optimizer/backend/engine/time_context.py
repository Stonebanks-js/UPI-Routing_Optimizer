"""
Time Context — Peak Hour Detection
====================================

Detects whether the current time falls within UPI peak hours.

India-specific context:
- UPI transaction volume peaks between 8:00 PM – 10:00 PM IST
- During peak hours, some apps experience higher failure rates
- The rule engine uses this signal to adjust scoring weights

Public API:
    is_peak_hour() -> bool
    get_time_window() -> str   # Returns 'peak' | 'off_peak'
    get_current_ist() -> datetime
"""

# TODO: Import datetime, timezone, timedelta

# TODO: Define IST timezone offset (UTC+5:30)
#   IST = timezone(timedelta(hours=5, minutes=30))

# TODO: Define peak hour range
#   PEAK_START_HOUR = 20  # 8:00 PM IST
#   PEAK_END_HOUR = 22    # 10:00 PM IST

# TODO: Define get_current_ist() function
#   - Returns current datetime in IST

# TODO: Define is_peak_hour() function
#   - Gets current IST hour
#   - Returns True if PEAK_START_HOUR <= hour < PEAK_END_HOUR

# TODO: Define get_time_window() function
#   - Returns 'peak' if is_peak_hour() else 'off_peak'
