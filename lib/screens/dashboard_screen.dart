import 'package:flutter/material.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/models/progress_photo.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';
import 'package:your_app/widgets/hormone_card.dart';
import 'package:your_app/widgets/body_stat_chart.dart';
import 'package:flutter_test/flutter_test.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  BodyStats? _latestBodyStat;
  Map<String, dynamic>? _latestHormone;
  ProgressPhoto? _latestProgressPhoto;
  final BodyStatsService _bodyStatsService = BodyStatsService();
  final HormoneTrackerService _hormoneTrackerService = HormoneTrackerService();
  final ProgressPhotosService _progressPhotosService = ProgressPhotosService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final latestBodyStat = await _bodyStatsService.getLatestBodyStat();
    final latestHormone = await _hormoneTrackerService.getLatestHormone();
    final latestProgressPhoto = await _progressPhotosService.getLatestProgressPhoto();
    setState(() {
      _latestBodyStat = latestBodyStat;
      _latestHormone = latestHormone;
      _latestProgressPhoto = latestProgressPhoto;
    });
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
        title: const Text('Dashboard'),
      ),
      body: ListView(
        children: [
          if (_latestBodyStat != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Body Stat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Weight: ${_latestBodyStat!.weight} kg'),
                    Text('Muscle Mass: ${_latestBodyStat!.muscleMass} kg'),
                    Text('Fat Percentage: ${_latestBodyStat!.fatPercentage} %'),
                  ],
                ),
              ),
            ),
          if (_latestProgressPhoto != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Progress Photo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.network(_latestProgressPhoto!.photoPath),
                  ],
                ),
              ),
            ),
          if (_latestHormone != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Hormone Entry',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    HormoneCard(
                      name: _latestHormone!['name'],
                      dosage: _latestHormone!['dosage'],
                      schedule: _latestHormone!['schedule'],
                      purpose: _latestHormone!['purpose'],
                    ),
                  ],
                ),
              ),
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
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: _navigateToScreen,
      ),
    );
  }
}

void main() {
  testWidgets('DashboardScreen displays latest body stat, hormone entry, and progress photo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardScreen()));

    // Verify the display of latest body stat
    expect(find.text('Latest Body Stat'), findsOneWidget);
    expect(find.text('Weight: 70 kg'), findsOneWidget);
    expect(find.text('Muscle Mass: 30 kg'), findsOneWidget);
    expect(find.text('Fat Percentage: 20 %'), findsOneWidget);

    // Verify the display of latest hormone entry
    expect(find.text('Latest Hormone Entry'), findsOneWidget);
    expect(find.text('Dosage: 50 mg'), findsOneWidget);
    expect(find.text('Schedule: Daily'), findsOneWidget);
    expect(find.text('Purpose: Muscle Growth'), findsOneWidget);

    // Verify the display of latest progress photo
    expect(find.text('Latest Progress Photo'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
