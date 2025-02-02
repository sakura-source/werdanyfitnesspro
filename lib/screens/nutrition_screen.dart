import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> meals = [
    {'name': 'Breakfast', 'calories': 300},
    {'name': 'Lunch', 'calories': 600},
    {'name': 'Dinner', 'calories': 500},
  ];

  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(meals[index]['name']),
            subtitle: Text('${meals[index]['calories']} calories'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add logic to add a new meal
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
