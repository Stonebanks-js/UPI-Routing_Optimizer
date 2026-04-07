// ============================================================
// Time Helpers — Peak Hour Detection (Client Side)
// ============================================================
//
// Client-side utility for detecting UPI peak hours in IST.
// Mirrors the backend's time_context.py logic so the app can
// display peak-hour indicators without an API call.
//
// India-specific:
// - UPI peak hours: 8:00 PM – 10:00 PM IST (UTC+5:30)
// - During these hours, some UPI apps experience higher failure rates
//
// Public API:
//
//   TimeHelpers.isPeakHour() → bool
//     - Returns true if current IST time is between 20:00–22:00
//
//   TimeHelpers.getTimeWindow() → String
//     - Returns 'peak' or 'off_peak'
//
//   TimeHelpers.getCurrentIST() → DateTime
//     - Returns current time in IST timezone
//
//   TimeHelpers.formatTimestamp(DateTime dt) → String
//     - Formats a DateTime to a human-readable IST string
//     - e.g., "7 Apr 2026, 9:15 PM IST"
//
// ============================================================

// TODO: Import intl package for date formatting

// TODO: Define IST offset: Duration(hours: 5, minutes: 30)

// TODO: Define peak hour constants
//   static const PEAK_START_HOUR = 20;  // 8:00 PM IST
//   static const PEAK_END_HOUR   = 22;  // 10:00 PM IST

// TODO: Define TimeHelpers class with static methods

// TODO: Define static getCurrentIST() method
//   - Get UTC now, add IST offset

// TODO: Define static isPeakHour() method
//   - Check if current IST hour is between 20 and 22

// TODO: Define static getTimeWindow() method
//   - Return 'peak' or 'off_peak'

// TODO: Define static formatTimestamp(DateTime dt) method
//   - Use intl DateFormat for human-readable output
