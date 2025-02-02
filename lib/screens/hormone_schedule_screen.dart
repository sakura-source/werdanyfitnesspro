import 'package:flutter/material.dart';
import 'package:your_app/services/hormone_tracker_service.dart';

class HormoneScheduleScreen extends StatefulWidget {
  const HormoneScheduleScreen({super.key});

  @override
  _HormoneScheduleScreenState createState() => _HormoneScheduleScreenState();
}

class _HormoneScheduleScreenState extends State<HormoneScheduleScreen> {
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  List<Map<String, dynamic>> _hormones = [];

  @override
  void initState() {
    super.initState();
    _loadHormones();
  }

  Future<void> _loadHormones() async {
    final hormones = await _hormoneTrackerService.getHormones();
    setState(() {
      _hormones = hormones;
    });
  }

  Future<void> _addHormone(String name, double dosage, String schedule, String purpose) async {
    await _hormoneTrackerService.addHormone(name, dosage, schedule, purpose);
    _loadHormones();
  }

  Future<void> _editHormone(int id, String name, double dosage, String schedule, String purpose) async {
    await _hormoneTrackerService.editHormone(id, name, dosage, schedule, purpose);
    _loadHormones();
  }

  Future<void> _deleteHormone(int id) async {
    await _hormoneTrackerService.deleteHormone(id);
    _loadHormones();
  }

  void _showAddHormoneDialog() {
    final nameController = TextEditingController();
    final dosageController = TextEditingController();
    final scheduleController = TextEditingController();
    final purposeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Hormone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: dosageController,
                decoration: const InputDecoration(labelText: 'Dosage'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: scheduleController,
                decoration: const InputDecoration(labelText: 'Schedule'),
              ),
              TextField(
                controller: purposeController,
                decoration: const InputDecoration(labelText: 'Purpose'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addHormone(
                  nameController.text,
                  double.parse(dosageController.text),
                  scheduleController.text,
                  purposeController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditHormoneDialog(Map<String, dynamic> hormone) {
    final nameController = TextEditingController(text: hormone['name']);
    final dosageController = TextEditingController(text: hormone['dosage'].toString());
    final scheduleController = TextEditingController(text: hormone['schedule']);
    final purposeController = TextEditingController(text: hormone['purpose']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Hormone'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: dosageController,
                decoration: const InputDecoration(labelText: 'Dosage'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: scheduleController,
                decoration: const InputDecoration(labelText: 'Schedule'),
              ),
              TextField(
                controller: purposeController,
                decoration: const InputDecoration(labelText: 'Purpose'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editHormone(
                  hormone['id'],
                  nameController.text,
                  double.parse(dosageController.text),
                  scheduleController.text,
                  purposeController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
        title: const Text('Hormone Schedule'),
      ),
      body: ListView.builder(
        itemCount: _hormones.length,
        itemBuilder: (context, index) {
          final hormone = _hormones[index];
          return ListTile(
            title: Text(hormone['name']),
            subtitle: Text('Dosage: ${hormone['dosage']} - Schedule: ${hormone['schedule']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditHormoneDialog(hormone),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteHormone(hormone['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHormoneDialog,
        child: const Icon(Icons.add),
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
        currentIndex: 3,
        selectedItemColor: Colors.blue,
        onTap: _navigateToScreen,
      ),
    );
  }
}
