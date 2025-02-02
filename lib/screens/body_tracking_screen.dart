import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/widgets/body_stat_chart.dart';

class BodyTrackingScreen extends StatefulWidget {
  const BodyTrackingScreen({super.key});

  @override
  _BodyTrackingScreenState createState() => _BodyTrackingScreenState();
}

class _BodyTrackingScreenState extends State<BodyTrackingScreen> {
  List<BodyStats> _bodyStats = [];
  final BodyStatsService _bodyStatsService = BodyStatsService();

  @override
  void initState() {
    super.initState();
    _loadBodyStats();
  }

  Future<void> _loadBodyStats() async {
    final stats = await _bodyStatsService.getBodyStats();
    setState(() {
      _bodyStats = stats;
    });
  }

  void _addBodyStat(BodyStats stat) async {
    await _bodyStatsService.addBodyStat(stat);
    _loadBodyStats();
  }

  void _editBodyStat(BodyStats stat) async {
    await _bodyStatsService.updateBodyStat(stat);
    _loadBodyStats();
  }

  void _deleteBodyStat(int id) async {
    await _bodyStatsService.deleteBodyStat(id);
    _loadBodyStats();
  }

  void _manageBodyStats() {
    // Add logic to add, edit, and delete body stats
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
        title: const Text('Body Tracking'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BodyStatChart(bodyStats: _bodyStats),
          ),
          ElevatedButton(
            onPressed: _manageBodyStats,
            child: const Text('Manage Body Stats'),
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
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        onTap: _navigateToScreen,
      ),
    );
  }
}
