import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

/// Handles assembling and executing deep links to launch installed UPI apps on Android.
class UpiLauncher {
  
  /// Helper used to craft and launch a UPI Intent for a matching app.
  /// Returns [true] if the app was successfully launched.
  static Future<bool> launchUpiApp({
    required String appName, // e.g., "gpay"
    required String upiId,
    required String amount,
    required String description,
  }) async {
    try {
      // Basic encode to handle spaces or special characters in description
      final encodedDesc = Uri.encodeComponent(description);
      final rawUri = 'upi://pay?pa=$upiId&pn=Merchant&am=$amount&tn=$encodedDesc';
      final uri = Uri.parse(rawUri);

      // Attempt to fire Android intent
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      
      return launched;
    } catch (e) {
      print('UpiLauncher launchUpiApp error: $e');
      return false;
    }
  }

  /// Probes the device to see which of our known UPI apps can handle
  /// standard UPI intents. Since Android 11, checking specific packages
  /// requires declaring queries in AndroidManifest.xml.
  /// Note: The actual `url_launcher` does not tell you WHICH app it will open,
  /// but we simulate an availability check. In a deep native approach,
  /// we'd query PackageManager directly per package.
  /// 
  /// Returns a list of apps currently available on this device.
  static Future<List<String>> getAvailableApps() async {
    try {
      final List<String> available = [];
      
      // Basic check over all known apps (we would ideally perform a platform channel 
      // call to check if specific packages are installed on Android).
      //
      // Because bare `canLaunchUrl` simply asks "can I launch upi://pay",
      // it won't filter by specific apps easily without direct package queries.
      // For now we'll pretend / mock that they are all returned, or check 
      // if `upi://pay` works entirely.
      
      final genericUpiIntent = Uri.parse('upi://pay?pa=test@upi&pn=Test');
      final canLaunch = await canLaunchUrl(genericUpiIntent);
      
      if (canLaunch) {
        // As long as the device handles upi links, we can return the defaults.
        // True verification of specific package installation requires android native queries.
        available.addAll(kUpiApps);
      }
      
      return available;
    } catch (e) {
      print('UpiLauncher getAvailableApps error: $e');
      return [];
    }
  }
}
