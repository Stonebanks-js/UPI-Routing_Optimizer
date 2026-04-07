// ============================================================
// UpiLauncher Service
// ============================================================
//
// Opens UPI apps (Google Pay, PhonePe, Paytm) via Android Intent.
//
// This service uses the url_launcher package to trigger UPI
// deep links on Android. It does NOT process payments — it simply
// opens the target app so the user can complete the payment there.
//
// Public API:
//   UpiLauncher.launch(appName: String) → Future<bool>
//     - Returns true if the app was successfully launched
//     - Returns false if the app is not installed or launch failed
//
//   UpiLauncher.isAppInstalled(appName: String) → Future<bool>
//     - Checks if a UPI app is available on the device
//
// UPI Deep Link Schemes:
//   - Google Pay:  tez://upi/pay?...  or  gpay://upi/pay?...
//   - PhonePe:     phonepe://pay?...
//   - Paytm:       paytmmp://pay?...
//
// Timing:
//   - Records the launch timestamp (start time)
//   - The calling screen calculates latency when the user returns
//
// ============================================================

// TODO: Import url_launcher package
// TODO: Import constants for UPI deep link schemes

// TODO: Define UpiLauncher class with static methods

// TODO: Define static launch(appName) method
//   - Look up the deep link URI for the given app
//   - Call launchUrl() with the URI
//   - Return success/failure

// TODO: Define static isAppInstalled(appName) method
//   - Call canLaunchUrl() to check availability
