// ============================================================
// ApiService — HTTP Client for FastAPI Backend
// ============================================================
//
// Handles all HTTP communication between the Flutter app and
// the FastAPI backend. Uses the `http` or `dio` package.
//
// Base URL is configured via constants.dart and can be switched
// between local dev (http://10.0.2.2:8000) and production
// (Railway.app hosted URL).
//
// Public API:
//
//   ApiService.getRecommendation(String userId)
//     → Future<Recommendation>
//     - GET /api/recommend?user_id=...
//
//   ApiService.logTransaction(Transaction txn)
//     → Future<bool>
//     - POST /api/log-transaction
//     - Body: JSON-encoded transaction data
//
//   ApiService.getStats({String? timeWindow, String? upiApp})
//     → Future<List<AppPerformance>>
//     - GET /api/stats?time_window=...&upi_app=...
//
//   ApiService.getUserTransactions(String userId, {int limit = 50})
//     → Future<List<Transaction>>
//     - GET /api/log-transaction?user_id=...&limit=...
//
// Error handling:
//   - Throws ApiException on non-2xx responses
//   - Includes timeout handling (10 second default)
//   - Logs errors for debugging
//
// ============================================================

// TODO: Import http or dio package
// TODO: Import dart:convert for JSON encoding/decoding
// TODO: Import models (Transaction, Recommendation)
// TODO: Import utils/constants.dart for API_BASE_URL

// TODO: Define ApiException class

// TODO: Define ApiService class with static methods

// TODO: Define static getRecommendation(userId) method
// TODO: Define static logTransaction(txn) method
// TODO: Define static getStats({timeWindow, upiApp}) method
// TODO: Define static getUserTransactions(userId, {limit}) method

// TODO: Define static _handleResponse(Response response) helper
//   - Check status code, parse JSON, throw on error
