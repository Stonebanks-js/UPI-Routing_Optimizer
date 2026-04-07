import 'package:flutter/material.dart';
import '../services/upi_launcher.dart';
import '../services/transaction_logger.dart';

class PayScreen extends StatefulWidget {
  final String appName;
  final String upiId;
  final String amount;
  final String description;

  const PayScreen({
    Key? key,
    required this.appName,
    required this.upiId,
    required this.amount,
    required this.description,
  }) : super(key: key);

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  Future<void> _launchPayment() async {
    final startTime = DateTime.now();

    // Trigger intent resolution
    await UpiLauncher.launchUpiApp(
      appName: widget.appName,
      upiId: widget.upiId,
      amount: widget.amount,
      description: widget.description,
    );

    if (!mounted) return;

    // Upon returning to the app, verify state manually in this demo application
    final bool? success = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Did payment succeed?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No ❌'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes ✅'),
            ),
          ],
        );
      },
    );

    if (success != null) {
      final endTime = DateTime.now();
      final latency = endTime.difference(startTime).inMilliseconds;
      final status = success ? 'success' : 'failure';

      // Record to backend invisibly
      await TransactionLogger.logAttempt(widget.appName, status, latency);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirm Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                widget.appName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 16),
            Text('App: ${widget.appName}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('Amount: ₹${widget.amount}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _launchPayment,
              icon: const Icon(Icons.rocket_launch),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text('Launch ${widget.appName}', style: const TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
