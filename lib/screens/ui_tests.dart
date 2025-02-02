import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/body_tracking_screen.dart';
import 'package:your_app/screens/dashboard_screen.dart';
import 'package:your_app/screens/diet_plan_screen.dart';
import 'package:your_app/screens/progress_photos_screen.dart';
import 'package:your_app/screens/trainer_dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  group('UI Tests', () {
    testWidgets('BodyTrackingScreen displays body stats and interacts with buttons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BodyTrackingScreen()));

      // Verify the display of body stats
      expect(find.text('Body Tracking'), findsOneWidget);

      // Verify interaction with buttons
      expect(find.text('Manage Body Stats'), findsOneWidget);
      await tester.tap(find.text('Manage Body Stats'));
      await tester.pump();

      // Add more test cases as needed
    });

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

    testWidgets('ProgressPhotosScreen displays progress photos and interacts with buttons', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProgressPhotosScreen()));

      // Verify the display of progress photos
      expect(find.text('Progress Photos'), findsOneWidget);
      expect(find.text('Latest Progress Photo'), findsOneWidget);

      // Verify interaction with buttons
      expect(find.text('Upload Photo'), findsOneWidget);
      await tester.tap(find.text('Upload Photo'));
      await tester.pump();

      // Add more test cases as needed
    });

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
  });
}
