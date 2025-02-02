import 'package:flutter/material.dart';

class HormoneTrackingScreen extends StatefulWidget {
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
        title: Text('Hormone Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: _injectionTypeController,
              decoration: InputDecoration(labelText: 'Injection Type'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addInjection,
              child: Text('Add Injection'),
            ),
            SizedBox(height: 16),
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
