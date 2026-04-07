// ============================================================
// HomeScreen — Dashboard + Recommendation Card
// ============================================================
//
// The main landing screen of the app. Displays:
//
// 1. A greeting header with the user's name
// 2. The RecommendationCard widget — shows the best UPI app to use
//    right now, with confidence score and reason
// 3. Quick-action buttons to launch each UPI app (GPay, PhonePe, Paytm)
// 4. A summary strip of recent transaction stats (last 24h success rate)
// 5. Bottom navigation bar linking to Pay, History, and Stats screens
//
// Data flow:
// - On screen load, calls ApiService.getRecommendation(userId)
// - Displays loading spinner while waiting for backend response
// - Caches the last recommendation locally via SharedPreferences
//
// ============================================================

// TODO: Import flutter/material.dart
// TODO: Import widgets (RecommendationCard, AppTile)
// TODO: Import services (ApiService)

// TODO: Define HomeScreen StatefulWidget

// TODO: Define _HomeScreenState
//   - initState() → fetch recommendation from API
//   - build() → Scaffold with:
//       - AppBar: "Smart UPI Optimizer"
//       - Body: Column with recommendation card, app tiles, stats summary
//       - BottomNavigationBar: Home, Pay, History, Stats
