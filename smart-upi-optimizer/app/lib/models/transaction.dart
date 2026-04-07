// ============================================================
// Transaction Model (Dart)
// ============================================================
//
// Data class representing a single UPI transaction record.
// Used for both sending data to the backend and displaying
// transaction history in the app.
//
// Fields:
// - id: String?               — UUID (null when creating, set by backend)
// - userId: String            — UUID of the user
// - upiApp: String            — 'google_pay' | 'phonepe' | 'paytm'
// - status: String            — 'success' | 'failure' | 'pending'
// - latencyMs: int            — response time in milliseconds
// - amountRange: String       — '0-500' | '500-2000' | '2000+'
// - errorCode: String?        — UPI error code if failed (nullable)
// - timestamp: DateTime?      — when the transaction occurred
//
// Methods:
// - Transaction.fromJson(Map<String, dynamic>)  — factory constructor
// - toJson() → Map<String, dynamic>             — serialization
//
// ============================================================

// TODO: Define Transaction class
//   - Declare all fields
//   - Define constructor with named parameters
//   - Define factory Transaction.fromJson(json)
//   - Define Map<String, dynamic> toJson()
//   - Define toString() for debugging
