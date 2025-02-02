import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:werdany_fitness_pro/main.dart';
import 'package:werdany_fitness_pro/services/body_stats_service.dart';
import 'package:werdany_fitness_pro/services/diet_plan_service.dart';
import 'package:werdany_fitness_pro/services/hormone_tracker_service.dart';
import 'package:werdany_fitness_pro/services/progress_photos_service.dart';
import 'package:werdany_fitness_pro/services/settings_service.dart';
import 'package:werdany_fitness_pro/screens/dashboard_screen.dart';
import 'package:werdany_fitness_pro/screens/diet_plan_screen.dart';
import 'package:werdany_fitness_pro/screens/progress_photos_screen.dart';
import 'package:werdany_fitness_pro/screens/trainer_dashboard_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('BodyStatsService getBodyStatsByDateRange', (WidgetTester tester) async {
    final bodyStatsService = BodyStatsService();
    final startDate = DateTime(2022, 1, 1);
    final endDate = DateTime(2022, 12, 31);
    final bodyStats = await bodyStatsService.getBodyStatsByDateRange(startDate, endDate);
    expect(bodyStats, isNotNull);
  });

  testWidgets('BodyStatsService getLatestBodyStat', (WidgetTester tester) async {
    final bodyStatsService = BodyStatsService();
    final latestBodyStat = await bodyStatsService.getLatestBodyStat();
    expect(latestBodyStat, isNotNull);
  });

  testWidgets('DietPlanService getDietPlanById', (WidgetTester tester) async {
    final dietPlanService = DietPlanService();
    final dietPlan = await dietPlanService.getDietPlanById(1);
    expect(dietPlan, isNotNull);
  });

  testWidgets('DietPlanService getLatestDietPlan', (WidgetTester tester) async {
    final dietPlanService = DietPlanService();
    final latestDietPlan = await dietPlanService.getLatestDietPlan();
    expect(latestDietPlan, isNotNull);
  });

  testWidgets('HormoneTrackerService getHormoneById', (WidgetTester tester) async {
    final hormoneTrackerService = HormoneTrackerService();
    final hormone = await hormoneTrackerService.getHormoneById(1);
    expect(hormone, isNotNull);
  });

  testWidgets('HormoneTrackerService getLatestHormone', (WidgetTester tester) async {
    final hormoneTrackerService = HormoneTrackerService();
    final latestHormone = await hormoneTrackerService.getLatestHormone();
    expect(latestHormone, isNotNull);
  });

  testWidgets('ProgressPhotosService getProgressPhotoById', (WidgetTester tester) async {
    final progressPhotosService = ProgressPhotosService();
    final progressPhoto = await progressPhotosService.getProgressPhotoById(1);
    expect(progressPhoto, isNotNull);
  });

  testWidgets('ProgressPhotosService getLatestProgressPhoto', (WidgetTester tester) async {
    final progressPhotosService = ProgressPhotosService();
    final latestProgressPhoto = await progressPhotosService.getLatestProgressPhoto();
    expect(latestProgressPhoto, isNotNull);
  });

  testWidgets('SettingsService getSettingsByUserId', (WidgetTester tester) async {
    final settingsService = SettingsService();
    final settings = await settingsService.getSettingsByUserId(1);
    expect(settings, isNotNull);
  });

  testWidgets('SettingsService getLatestSettings', (WidgetTester tester) async {
    final settingsService = SettingsService();
    final latestSettings = await settingsService.getLatestSettings();
    expect(latestSettings, isNotNull);
  });

  testWidgets('DashboardScreen displays latest entries', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DashboardScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Latest Body Stat'), findsOneWidget);
    expect(find.text('Latest Progress Photo'), findsOneWidget);
    expect(find.text('Latest Hormone Entry'), findsOneWidget);
  });

  testWidgets('DietPlanScreen displays latest diet plan', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DietPlanScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Latest Diet Plan'), findsOneWidget);
  });

  testWidgets('ProgressPhotosScreen displays latest progress photo', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProgressPhotosScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Latest Progress Photo'), findsOneWidget);
  });

  testWidgets('TrainerDashboardScreen displays latest client', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TrainerDashboardScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Latest Client'), findsOneWidget);
  });
}
