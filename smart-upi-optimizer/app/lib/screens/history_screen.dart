import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  List<dynamic> _history = [];

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });

    // The instructions say to use /stats/performance for now to fill the list.
    final data = await ApiService.getStats();

    setState(() {
      if (data is List) {
        _history = data;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Logs')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _history.isEmpty
                ? const Center(child: Text('No transactions yet'))
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      final item = _history[index];
                      final appName = item['app_name'] ?? 'Unknown';
                      
                      // Using the available fields structurally. Since stats endpoints return aggregates, 
                      // we map logic for ✅ / ❌ based on success properties per instructions requirements.
                      final isSuccess = (item['success_rate'] ?? 0.0) >= 0.5;
                      final timestamp = item['last_updated'] ?? 'Unknown time';

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(appName.substring(0, 1).toUpperCase()),
                        ),
                        title: Text(appName),
                        subtitle: Text(timestamp),
                        trailing: Text(
                          isSuccess ? '✅' : '❌',
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
