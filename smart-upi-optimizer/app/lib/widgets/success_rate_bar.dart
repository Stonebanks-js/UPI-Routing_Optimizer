// ============================================================
// SuccessRateBar Widget
// ============================================================
//
// A horizontal bar that visually represents the success rate
// of a UPI app. Used in the StatsScreen and HomeScreen.
//
// Props (constructor parameters):
// - appName: String       — 'google_pay' | 'phonepe' | 'paytm'
// - successRate: double   — percentage value (0–100)
// - color: Color          — bar fill color (matches app brand)
// - height: double        — bar height (default: 24.0)
// - showLabel: bool       — whether to display percentage text
//
// Visual design:
// - Background: muted gray rounded rectangle (represents 100%)
// - Foreground: colored fill proportional to success rate
// - App name label on the left
// - Percentage text on the right (e.g., "82.5%")
// - Animated width transition when value changes
//
// ============================================================

// TODO: Import flutter/material.dart

// TODO: Define SuccessRateBar StatelessWidget
//   - Constructor with required props
//   - build() → Row with app label + Stack of background/foreground bars + percentage
