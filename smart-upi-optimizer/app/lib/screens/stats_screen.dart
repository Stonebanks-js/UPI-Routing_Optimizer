// ============================================================
// StatsScreen — Success Rate Charts & Analytics
// ============================================================
//
// Displays visual analytics of UPI app performance.
//
// Layout:
// 1. Header: "Performance Analytics"
// 2. Time window toggle: Peak / Off-Peak / All Day
// 3. Bar chart (fl_chart): success rate comparison across all 3 apps
// 4. Line chart: success rate trend over the last 7 days
// 5. Summary cards for each app:
//    - Success rate percentage
//    - Average latency
//    - Total transactions
// 6. SuccessRateBar widgets for quick visual comparison
//
// Data flow:
// - On load, calls ApiService.getStats(timeWindow)
// - Charts rebuild when time window toggle changes
//
// ============================================================

// TODO: Import flutter/material.dart
// TODO: Import fl_chart package
// TODO: Import services (ApiService)
// TODO: Import widgets (SuccessRateBar)

// TODO: Define StatsScreen StatefulWidget

// TODO: Define _StatsScreenState
//   - _timeWindow: String — 'all_day' | 'peak' | 'off_peak'
//   - _stats: List<AppPerformance>
//   - _isLoading: bool
//   - _fetchStats() → calls ApiService.getStats(_timeWindow)
//   - _buildBarChart() → returns fl_chart BarChart widget
//   - _buildSummaryCards() → returns Row of stat cards
//   - build() → Scaffold with toggle, charts, and summary cards
