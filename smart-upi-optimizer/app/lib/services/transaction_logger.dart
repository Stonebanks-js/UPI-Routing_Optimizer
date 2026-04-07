import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'api_service.dart';

/// Orchestrates local user identification and transaction logging.
class TransactionLogger {
  static const String _userIdKey = 'app_user_id';
  static const _uuid = Uuid();

  /// Retrieves the existing user ID from local storage.
  /// If it does not exist, generates a new one, saves it, and returns it.
  static Future<String> getOrCreateUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString(_userIdKey);

      if (userId == null || userId.isEmpty) {
        userId = _uuid.v4(); // Generate a random UUIDv4
        await prefs.setString(_userIdKey, userId);
      }

      return userId;
    } catch (e) {
      print('TransactionLogger getOrCreateUserId error: $e');
      // Fallback in case of exceptions so the app still functions
      return _uuid.v4(); 
    }
  }

  /// High-level function to log a transaction. It securely injects the
  /// device's user_id before calling the API layer.
  static Future<bool> logAttempt(
      String appUsed, String status, int latencyMs) async {
    try {
      final String userId = await getOrCreateUserId();
      return await ApiService.logTransaction(
          userId, appUsed, status, latencyMs);
    } catch (e) {
      print('TransactionLogger logAttempt error: $e');
      return false;
    }
  }
}
