import 'package:flutter/material.dart';

class HormoneTrackingScreen extends StatefulWidget {
  const HormoneTrackingScreen({super.key});

  @override
  _HormoneTrackingScreenState createState() => _HormoneTrackingScreenState();
}

class _HormoneTrackingScreenState extends State<HormoneTrackingScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _injectionTypeController = TextEditingController();
  final List<Map<String, String>> _injections = [];

  void _addInjection() {
    setState(() {
      _injections.add({
        'date': _dateController.text,
        'type': _injectionTypeController.text,
      });
      _dateController.clear();
      _injectionTypeController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hormone Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _injectionTypeController,
              decoration: const InputDecoration(labelText: 'Injection Type'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addInjection,
              child: const Text('Add Injection'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _injections.length,
                itemBuilder: (context, index) {
                  final injection = _injections[index];
                  return ListTile(
                    title: Text('Date: ${injection['date']}'),
                    subtitle: Text('Type: ${injection['type']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
