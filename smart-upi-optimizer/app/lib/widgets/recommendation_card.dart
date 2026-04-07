import 'package:flutter/material.dart';
import '../models/recommendation.dart';
import '../utils/constants.dart';

class RecommendationCard extends StatelessWidget {
  final Recommendation recommendation;

  const RecommendationCard({Key? key, required this.recommendation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isHighConfidence = recommendation.confidenceScore > 0.7;
    final Color bgColor = isHighConfidence ? kGreen.withOpacity(0.2) : kOrange.withOpacity(0.2);

    return Card(
      color: bgColor,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Best right now: ${recommendation.suggestedApp}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: recommendation.confidenceScore,
              color: isHighConfidence ? kGreen : kOrange,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 8),
            if (recommendation.reason != null)
              Text(
                recommendation.reason!,
                style: const TextStyle(fontSize: 14),
              ),
            if (recommendation.avoidApps.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text('Avoid right now:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: recommendation.avoidApps.map((app) {
                  return Chip(
                    label: Text(app, style: const TextStyle(color: Colors.white)),
                    backgroundColor: kRed,
                  );
                }).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
