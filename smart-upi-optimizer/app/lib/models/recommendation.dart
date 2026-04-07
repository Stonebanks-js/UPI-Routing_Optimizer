/// Model representing a recommendation returned by the backend engine.
class Recommendation {
  final String suggestedApp;
  final double confidenceScore;
  final String? reason;
  final List<String> avoidApps;

  Recommendation({
    required this.suggestedApp,
    required this.confidenceScore,
    this.reason,
    required this.avoidApps,
  });

  /// Decodes JSON from the backend into a Recommendation model.
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      suggestedApp: json['suggested_app'] ?? 'gpay', // Safe default fallback
      confidenceScore: (json['confidence_score'] ?? 0.0).toDouble(),
      reason: json['reason'] as String?,
      avoidApps: (json['avoid_apps'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
