// ============================================================
// Recommendation Model (Dart)
// ============================================================
//
// Data class representing a UPI app recommendation from the
// backend engine. Displayed in the RecommendationCard widget.
//
// Fields:
// - recommendedApp: String    — 'google_pay' | 'phonepe' | 'paytm'
// - score: double             — confidence score (0–100)
// - reason: String            — human-readable explanation
// - alternatives: List<AppScore> — ranked list of other apps
// - isPeakHour: bool          — whether peak-hour adjustment is active
// - timestamp: DateTime       — when the recommendation was generated
//
// AppScore sub-model:
// - upiApp: String
// - successRate: double
// - avgLatencyMs: int
// - compositeScore: double
//
// Methods:
// - Recommendation.fromJson(Map<String, dynamic>)  — factory constructor
// - toJson() → Map<String, dynamic>                — serialization
//
// ============================================================

// TODO: Define AppScore class
//   - Declare fields
//   - Define factory AppScore.fromJson(json)
//   - Define toJson()

// TODO: Define Recommendation class
//   - Declare all fields
//   - Define constructor with named parameters
//   - Define factory Recommendation.fromJson(json)
//   - Define toJson()
//   - Define toString() for debugging
