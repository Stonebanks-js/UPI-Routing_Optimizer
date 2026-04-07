/// Model representing a single UPI transaction log.
class Transaction {
  final String? txnId;
  final String userId;
  final String appUsed;
  final String status;
  final int latencyMs;
  final String? timestamp;

  Transaction({
    this.txnId,
    required this.userId,
    required this.appUsed,
    required this.status,
    required this.latencyMs,
    this.timestamp,
  });

  /// Decodes JSON from the backend into a Transaction model.
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      txnId: json['txn_id'] as String?,
      userId: json['user_id'] as String,
      appUsed: json['app_used'] as String,
      status: json['status'] as String,
      latencyMs: json['latency_ms'] as int,
      timestamp: json['timestamp'] as String?,
    );
  }

  /// Encodes the Transaction model back into JSON for API requests.
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'app_used': appUsed,
      'status': status,
      'latency_ms': latencyMs,
    };
  }
}
