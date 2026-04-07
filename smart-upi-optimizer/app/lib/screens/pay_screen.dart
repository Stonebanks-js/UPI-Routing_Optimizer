// ============================================================
// PayScreen — Trigger UPI App via Android Intent
// ============================================================
//
// Allows the user to initiate a UPI payment through a selected app.
//
// Layout:
// 1. Amount input field (for display/bucketing only — NOT sent to UPI)
// 2. UPI app selector — 3 large tiles (GPay, PhonePe, Paytm)
//    with a "Recommended" badge on the top-ranked app
// 3. "Pay Now" button that launches the selected UPI app via
//    Android Intent (using url_launcher / upi_india package)
//
// Flow:
// - User selects an app and taps "Pay Now"
// - UpiLauncher.launch(appName) opens the UPI app
// - After the user returns, TransactionLogger.log(...) sends
//   the outcome (success/failure + latency) to the backend
// - A confirmation snackbar is shown
//
// ============================================================

// TODO: Import flutter/material.dart
// TODO: Import services (UpiLauncher, TransactionLogger)
// TODO: Import widgets (AppTile)
// TODO: Import models (Transaction)

// TODO: Define PayScreen StatefulWidget

// TODO: Define _PayScreenState
//   - _selectedApp: String? — which UPI app is selected
//   - _amountRange: String — bucketed amount range
//   - _isProcessing: bool — loading state
//   - _launchPayment() → calls UpiLauncher, then logs result
//   - build() → Scaffold with app selector, amount input, pay button
