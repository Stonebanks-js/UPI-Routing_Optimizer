// ============================================================
// TransactionLogger Service
// ============================================================
//
// Logs each UPI payment attempt (success or failure) to the
// FastAPI backend for performance tracking and analysis.
//
// This service is called AFTER the user returns from a UPI app.
// It captures the outcome and sends it to POST /api/log-transaction.
//
// Public API:
//   TransactionLogger.log({
//     required String userId,
//     required String upiApp,
//     required String status,        // 'success' | 'failure'
//     required int latencyMs,
//     required String amountRange,
//     String? errorCode,
//   }) → Future<bool>
//     - Returns true if the transaction was logged successfully
//     - Returns false if the API call failed (will retry later)
//
// Offline handling:
//   - If the device is offline, the transaction is queued locally
//     using SharedPreferences and retried on next app launch
//
// ============================================================

// TODO: Import services/api_service.dart
// TODO: Import models/transaction.dart
// TODO: Import shared_preferences package

// TODO: Define TransactionLogger class

// TODO: Define static log(...) method
//   - Build a Transaction object from parameters
//   - Call ApiService.logTransaction(transaction)
//   - On failure, queue locally for retry

// TODO: Define static _retryPending() method
//   - Check SharedPreferences for queued transactions
//   - Attempt to send each one
//   - Remove from queue on success
