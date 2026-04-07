import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  bool _isLoading = true;
  List<dynamic> _stats = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });

    final data = await ApiService.getStats();

    setState(() {
      if (data is List) {
        _stats = data;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Dashboard')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _stats.length,
                itemBuilder: (context, index) {
                  final stat = _stats[index];
                  final String appName = stat['app_name'] ?? 'Unknown';
                  final double successRate = (stat['success_rate'] ?? 0.0).toDouble();
                  final double latency = (stat['avg_latency_ms'] ?? 0.0).toDouble();

                  Color cardColor;
                  if (successRate > 0.7) {
                    cardColor = kGreen;
                  } else if (successRate >= 0.4) {
                    cardColor = kOrange;
                  } else {
                    cardColor = kRed;
                  }

                  final percentage = (successRate * 100).toStringAsFixed(1);

                  return Card(
                    color: cardColor.withOpacity(0.15),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appName,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text('Success Rate: $percentage%', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('Avg Latency: ${latency.toStringAsFixed(0)} ms', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
