import 'package:flutter/material.dart';
import 'package:your_app/services/diet_plan_service.dart';
import 'package:your_app/models/diet_plan.dart';
import 'package:your_app/widgets/diet_card.dart';
import 'package:flutter_test/flutter_test.dart';

class DietPlanScreen extends StatefulWidget {
  const DietPlanScreen({super.key});

  @override
  _DietPlanScreenState createState() => _DietPlanScreenState();
}

class _DietPlanScreenState extends State<DietPlanScreen> {
  List<DietPlan> _dietPlans = [];
  DietPlan? _latestDietPlan;
  final DietPlanService _dietPlanService = DietPlanService();

  @override
  void initState() {
    super.initState();
    _loadDietPlans();
  }

  Future<void> _loadDietPlans() async {
    final plans = await _dietPlanService.getDietPlans();
    final latestPlan = await _dietPlanService.getLatestDietPlan();
    setState(() {
      _dietPlans = plans;
      _latestDietPlan = latestPlan;
    });
  }

  void _addDietPlan(DietPlan plan) async {
    await _dietPlanService.addDietPlan(plan);
    _loadDietPlans();
  }

  void _editDietPlan(DietPlan plan) async {
    await _dietPlanService.updateDietPlan(plan);
    _loadDietPlans();
  }

  void _deleteDietPlan(int id) async {
    await _dietPlanService.deleteDietPlan(id);
    _loadDietPlans();
  }

  void _manageDietPlans() {
    // Add logic to add, edit, and delete diet plans
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/body_tracking');
        break;
      case 2:
        Navigator.pushNamed(context, '/diet_plan');
        break;
      case 3:
        Navigator.pushNamed(context, '/hormone_schedule');
        break;
      case 4:
        Navigator.pushNamed(context, '/progress_photos');
        break;
      case 5:
        Navigator.pushNamed(context, '/trainer_dashboard');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet Plans'),
      ),
      body: Column(
        children: [
          if (_latestDietPlan != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Diet Plan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Name: ${_latestDietPlan!.name}'),
                    Text('Calories: ${_latestDietPlan!.calories}'),
                    Text('Protein: ${_latestDietPlan!.protein}g'),
                    Text('Carbs: ${_latestDietPlan!.carbs}g'),
                    Text('Fats: ${_latestDietPlan!.fats}g'),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _dietPlans.length,
              itemBuilder: (context, index) {
                return DietCard(
                  dietPlan: _dietPlans[index],
                  onEdit: _editDietPlan,
                  onDelete: _deleteDietPlan,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _manageDietPlans,
            child: const Text('Manage Diet Plans'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Body Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Diet Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Hormone Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Progress Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Trainer Dashboard',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        onTap: _navigateToScreen,
      ),
    );
  }
}

void main() {
  testWidgets('DietPlanScreen displays diet plans and interacts with buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DietPlanScreen()));

    // Verify the display of diet plans
    expect(find.text('Diet Plans'), findsOneWidget);
    expect(find.text('Latest Diet Plan'), findsOneWidget);

    // Verify interaction with buttons
    expect(find.text('Manage Diet Plans'), findsOneWidget);
    await tester.tap(find.text('Manage Diet Plans'));
    await tester.pump();

    // Add more test cases as needed
  });
}
