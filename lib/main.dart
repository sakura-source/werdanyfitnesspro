import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:your_app/providers/navigation_provider.dart';
import 'package:your_app/screens/body_tracking_screen.dart';
import 'package:your_app/screens/dashboard_screen.dart';
import 'package:your_app/screens/diet_plan_screen.dart';
import 'package:your_app/screens/hormone_schedule_screen.dart';
import 'package:your_app/screens/login_screen.dart';
import 'package:your_app/screens/progress_photos_screen.dart';
import 'package:your_app/screens/trainer_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/body_tracking': (context) => const BodyTrackingScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/diet_plan': (context) => const DietPlanScreen(),
        '/hormone_schedule': (context) => const HormoneScheduleScreen(),
        '/login': (context) => const LoginScreen(),
        '/progress_photos': (context) => const ProgressPhotosScreen(),
        '/trainer_dashboard': (context) => const TrainerDashboardScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}