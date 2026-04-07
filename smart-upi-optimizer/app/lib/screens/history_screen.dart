// ============================================================
// HistoryScreen — Past Transactions List
// ============================================================
//
// Displays a scrollable list of the user's past UPI payment attempts.
//
// Layout:
// 1. Filter chips at the top: All, Google Pay, PhonePe, Paytm
// 2. Date range selector (last 7 days, 30 days, all time)
// 3. ListView of transaction cards, each showing:
//    - UPI app icon and name
//    - Status badge (Success ✓ / Failed ✗)
//    - Latency (e.g., "320ms")
//    - Amount range
//    - Timestamp (formatted in IST)
// 4. Pull-to-refresh to reload from backend
// 5. Empty state illustration if no transactions yet
//
// Data flow:
// - On load, calls ApiService.getUserTransactions(userId)
// - Supports local filtering by app name and status
//
// ============================================================

// TODO: Import flutter/material.dart
// TODO: Import services (ApiService)
// TODO: Import models (Transaction)

// TODO: Define HistoryScreen StatefulWidget

// TODO: Define _HistoryScreenState
//   - _transactions: List<Transaction>
//   - _filterApp: String? — active app filter
//   - _isLoading: bool
//   - _fetchTransactions() → loads from API
//   - _applyFilter(appName) → filters displayed list
//   - build() → Scaffold with filter chips + ListView.builder
