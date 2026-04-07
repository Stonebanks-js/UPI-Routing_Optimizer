import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/recommendation.dart';

/// Service responsible for communicating directly with the FastAPI backend.
class ApiService {
  /// Logs a transaction outcome (success/failure) directly to the backend.
  /// Returns a boolean indicating if it submitted successfully.
  static Future<bool> logTransaction(
      String userId, String appUsed, String status, int latencyMs) async {
    try {
      final url = Uri.parse('$kBaseUrl/transactions/log');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'app_used': appUsed,
          'status': status,
          'latency_ms': latencyMs,
        }),
      );
      
      // If the backend returns a 200/201, it created the transaction.
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      }
      return false;
    } catch (e) {
      // Handles errors silently and logs them to the console.
      print('ApiService logTransaction error: $e');
      return false;
    }
  }

  /// Requests a routing recommendation given the userId and apps installed on their device.
  /// Returns a [Recommendation] object if successful, or null on error.
  static Future<Recommendation?> getRecommendation(
      String userId, List<String> availableApps) async {
    try {
      // We pass the apps as a comma-separated query param.
      // E.g. /recommendations/suggest?user_id=123&available_apps=gpay,phonepe
      final queryParams = {
        'user_id': userId,
        'available_apps': availableApps.join(','),
      };
      final uri = Uri.parse('$kBaseUrl/recommendations/suggest')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        return Recommendation.fromJson(decoded);
      }
      return null;
    } catch (e) {
      print('ApiService getRecommendation error: $e');
      return null;
    }
  }

  /// Requests the general app performance statistics.
  /// Returns the JSON structure as a Map or List, or null on error.
  static Future<dynamic> getStats() async {
    try {
      final url = Uri.parse('$kBaseUrl/stats/performance');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('ApiService getStats error: $e');
      return null;
    }
  }
}
