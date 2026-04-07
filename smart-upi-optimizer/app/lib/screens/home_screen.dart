import 'package:flutter/material.dart';
import '../models/recommendation.dart';
import '../services/api_service.dart';
import '../services/transaction_logger.dart';
import '../utils/constants.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/app_tile.dart';
import '../widgets/success_rate_bar.dart';
import 'history_screen.dart';
import 'pay_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  Recommendation? _recommendation;
  dynamic _stats;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });

    final String userId = await TransactionLogger.getOrCreateUserId();
    
    // Calls both endpoints independently. Handled inside services.
    final rec = await ApiService.getRecommendation(userId, kUpiApps);
    final stats = await ApiService.getStats();

    setState(() {
      _recommendation = rec;
      _stats = stats;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart UPI'),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  if (_recommendation != null)
                    RecommendationCard(recommendation: _recommendation!),
                  if (_recommendation == null)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Fetching data...', style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('Pay via:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...kUpiApps.map((app) {
                    return AppTile(
                      appName: app,
                      isSuggested: _recommendation?.suggestedApp == app,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayScreen(
                              appName: app,
                              upiId: 'merchant@test',
                              amount: '1.00',
                              description: 'Test transaction',
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0, left: 16.0, bottom: 8.0),
                    child: Text('App Success Rates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  if (_stats != null && _stats is List)
                    ...(_stats as List).map((stat) {
                      final appName = stat['app_name'] ?? 'Unknown';
                      final double successRate = (stat['success_rate'] ?? 0.0).toDouble();
                      return SuccessRateBar(appName: appName, successRate: successRate);
                    }).toList()
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        },
        child: const Icon(Icons.history),
      ),
    );
  }
}
