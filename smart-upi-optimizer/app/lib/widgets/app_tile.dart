import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppTile extends StatelessWidget {
  final String appName;
  final VoidCallback onTap;
  final bool isSuggested;

  const AppTile({
    Key? key,
    required this.appName,
    required this.onTap,
    this.isSuggested = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          side: isSuggested
              ? const BorderSide(color: kGreen, width: 2)
              : BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: kPrimary.withOpacity(0.2),
            child: Text(
              appName.isNotEmpty ? appName.substring(0, 1).toUpperCase() : '?',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(appName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
