import 'package:flutter/material.dart';
import 'package:your_app/services/trainer_profile_service.dart';
import 'package:your_app/models/trainer_profile.dart';
import 'package:your_app/widgets/client_card.dart';
import 'package:flutter_test/flutter_test.dart';

class TrainerDashboardScreen extends StatefulWidget {
  const TrainerDashboardScreen({super.key});

  @override
  _TrainerDashboardScreenState createState() => _TrainerDashboardScreenState();
}

class _TrainerDashboardScreenState extends State<TrainerDashboardScreen> {
  List<TrainerProfile> _clients = [];
  TrainerProfile? _latestClient;
  final TrainerProfileService _trainerProfileService = TrainerProfileService();

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    final clients = await _trainerProfileService.getClients();
    final latestClient = await _trainerProfileService.getLatestClient();
    setState(() {
      _clients = clients;
      _latestClient = latestClient;
    });
  }

  void _addClient(TrainerProfile client) async {
    await _trainerProfileService.addClient(client);
    _loadClients();
  }

  void _editClient(TrainerProfile client) async {
    await _trainerProfileService.updateClient(client);
    _loadClients();
  }

  void _deleteClient(int id) async {
    await _trainerProfileService.deleteClient(id);
    _loadClients();
  }

  void _manageClients() {
    // Add logic to add, edit, and delete clients
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
        title: const Text('Trainer Dashboard'),
      ),
      body: Column(
        children: [
          if (_latestClient != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Client',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Name: ${_latestClient!.name}'),
                    Text('Email: ${_latestClient!.email}'),
                    Text('Phone: ${_latestClient!.phone}'),
                    Text('Address: ${_latestClient!.address}'),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                return ClientCard(
                  client: _clients[index],
                  onEdit: _editClient,
                  onDelete: _deleteClient,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _manageClients,
            child: const Text('Manage Clients'),
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
        currentIndex: 5,
        selectedItemColor: Colors.blue,
        onTap: _navigateToScreen,
      ),
    );
  }
}

void main() {
  testWidgets('TrainerDashboardScreen displays clients and interacts with buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TrainerDashboardScreen()));

    // Verify the display of clients
    expect(find.text('Trainer Dashboard'), findsOneWidget);
    expect(find.text('Latest Client'), findsOneWidget);

    // Verify interaction with buttons
    expect(find.text('Manage Clients'), findsOneWidget);
    await tester.tap(find.text('Manage Clients'));
    await tester.pump();

    // Add more test cases as needed
  });
}
