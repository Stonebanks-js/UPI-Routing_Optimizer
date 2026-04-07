import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SuccessRateBar extends StatelessWidget {
  final String appName;
  final double successRate;

  const SuccessRateBar({
    Key? key,
    required this.appName,
    required this.successRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color barColor;
    if (successRate > 0.7) {
      barColor = kGreen;
    } else if (successRate >= 0.4) {
      barColor = kOrange;
    } else {
      barColor = kRed;
    }

    final percentage = (successRate * 100).toStringAsFixed(1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(appName, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: successRate,
              color: barColor,
              backgroundColor: Colors.grey[300],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 50,
            child: Text('$percentage%', textAlign: TextAlign.right),
          )
        ],
      ),
    );
  }
}
