// ============================================================
// AppTile Widget
// ============================================================
//
// A tappable tile representing a single UPI app (Google Pay,
// PhonePe, or Paytm). Used on the HomeScreen and PayScreen.
//
// Props (constructor parameters):
// - appName: String           — 'google_pay' | 'phonepe' | 'paytm'
// - displayName: String       — human-readable name (e.g., "Google Pay")
// - isRecommended: bool       — shows a "Recommended" badge if true
// - isSelected: bool          — highlights the tile when selected
// - successRate: double?      — optional success rate to display
// - onTap: VoidCallback       — callback when tile is tapped
//
// Visual design:
// - Rounded rectangle with app brand color as accent
// - App icon/logo centered
// - Display name below the icon
// - Optional "Recommended ★" badge in top-right corner
// - Selected state: elevated shadow + border highlight
// - Ripple effect on tap
//
// ============================================================

// TODO: Import flutter/material.dart
// TODO: Import utils/constants.dart for brand colors

// TODO: Define AppTile StatelessWidget
//   - Constructor with required props
//   - build() → InkWell wrapping a decorated Container
//     with icon, name, optional badge, and selection highlight
