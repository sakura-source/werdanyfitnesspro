import 'package:flutter/material.dart';
import 'package:your_app/models/diet_plan.dart';

class DietCard extends StatelessWidget {
  final DietPlan dietPlan;
  final Function(DietPlan) onEdit;
  final Function(int) onDelete;

  const DietCard({super.key, 
    required this.dietPlan,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Diet Plan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Calories: ${dietPlan.calories}'),
            const SizedBox(height: 8),
            Text('Protein: ${dietPlan.protein}g'),
            const SizedBox(height: 8),
            Text('Carbs: ${dietPlan.carbs}g'),
            const SizedBox(height: 8),
            Text('Fats: ${dietPlan.fats}g'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEdit(dietPlan),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => onDelete(dietPlan.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
