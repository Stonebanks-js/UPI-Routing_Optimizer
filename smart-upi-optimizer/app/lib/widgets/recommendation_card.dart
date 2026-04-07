// ============================================================
// RecommendationCard Widget
// ============================================================
//
// A prominent, visually striking card displayed on the HomeScreen
// that shows the current best UPI app recommendation.
//
// Props (constructor parameters):
// - recommendedApp: String    — 'google_pay' | 'phonepe' | 'paytm'
// - score: double             — confidence score (0–100)
// - reason: String            — human-readable explanation
// - isPeakHour: bool          — whether peak-hour adjustment is active
// - onTap: VoidCallback       — navigates to PayScreen with this app pre-selected
//
// Visual design:
// - Gradient background matching the recommended app's brand color
// - App icon/logo at the top
// - Large score display (e.g., "87.5" with a circular progress indicator)
// - Reason text below the score
// - Peak hour indicator badge (if applicable)
// - Subtle glow/shadow animation for emphasis
//
// ============================================================

// TODO: Import flutter/material.dart
// TODO: Import utils/constants.dart for app colors and icons

// TODO: Define RecommendationCard StatelessWidget
//   - Constructor with required props
//   - build() → animated Container with gradient, icon, score, reason text
