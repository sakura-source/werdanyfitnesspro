import 'package:flutter/material.dart';

class HormoneCard extends StatelessWidget {
  final String name;
  final double dosage;
  final String schedule;
  final String purpose;

  const HormoneCard({super.key, 
    required this.name,
    required this.dosage,
    required this.schedule,
    required this.purpose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Dosage: $dosage'),
            const SizedBox(height: 8),
            Text('Schedule: $schedule'),
            const SizedBox(height: 8),
            Text('Purpose: $purpose'),
          ],
        ),
      ),
    );
  }
}
