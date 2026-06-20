import 'package:flutter/material.dart';

class BuddyWidget extends StatelessWidget {
  final bool happy;

  const BuddyWidget({super.key, required this.happy});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 65,
      backgroundColor: Colors.orange.shade100,
      child: Icon(
        happy ? Icons.sentiment_very_satisfied : Icons.smart_toy,
        size: 70,
      ),
    );
  }
}
