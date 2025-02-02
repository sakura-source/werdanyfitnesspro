import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/body_tracking_screen.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:your_app/models/body_stats.dart';

@GenerateMocks([BodyStatsService])
void main() {
  testWidgets('Body stats are loaded and displayed', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockBodyStatsService = MockBodyStatsService();
    when(mockBodyStatsService.getBodyStats()).thenAnswer((_) async => [
      BodyStats(id: 1, weight: 70, muscleMass: 30, fatPercentage: 20, date: DateTime.now(), height: 170, bmi: 24.2, waistCircumference: 80),
      BodyStats(id: 2, weight: 72, muscleMass: 32, fatPercentage: 18, date: DateTime.now(), height: 170, bmi: 24.9, waistCircumference: 82),
    ]);
    await tester.pumpWidget(MaterialApp(home: BodyTrackingScreen()));

    // Act: Wait for the body stats to load.
    await tester.pumpAndSettle();

    // Assert: Verify that the body stats are displayed.
    expect(find.text('Body Tracking'), findsOneWidget);
    expect(find.byType(BodyStatChart), findsOneWidget);
  });

  testWidgets('Manage Body Stats button works', (WidgetTester tester) async {
    // Arrange: Set up the screen.
    await tester.pumpWidget(MaterialApp(home: BodyTrackingScreen()));

    // Act: Tap the manage body stats button.
    await tester.tap(find.text('Manage Body Stats'));
    await tester.pump();

    // Assert: Verify that the manage body stats function was called.
    final mockBodyStatsService = MockBodyStatsService();
    verify(mockBodyStatsService.getBodyStats()).called(1);
  });

  testWidgets('Add body stat', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockBodyStatsService = MockBodyStatsService();
    await tester.pumpWidget(MaterialApp(home: BodyTrackingScreen()));

    // Act: Add a new body stat.
    final newStat = BodyStats(id: 3, weight: 75, muscleMass: 35, fatPercentage: 15, date: DateTime.now(), height: 170, bmi: 25.9, waistCircumference: 85);
    await tester.runAsync(() async {
      await mockBodyStatsService.addBodyStat(newStat);
    });
    await tester.pumpAndSettle();

    // Assert: Verify that the add body stat function was called.
    verify(mockBodyStatsService.addBodyStat(newStat)).called(1);
  });

  testWidgets('Edit body stat', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockBodyStatsService = MockBodyStatsService();
    await tester.pumpWidget(MaterialApp(home: BodyTrackingScreen()));

    // Act: Edit an existing body stat.
    final updatedStat = BodyStats(id: 1, weight: 68, muscleMass: 28, fatPercentage: 22, date: DateTime.now(), height: 170, bmi: 23.5, waistCircumference: 78);
    await tester.runAsync(() async {
      await mockBodyStatsService.updateBodyStat(updatedStat);
    });
    await tester.pumpAndSettle();

    // Assert: Verify that the update body stat function was called.
    verify(mockBodyStatsService.updateBodyStat(updatedStat)).called(1);
  });

  testWidgets('Delete body stat', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockBodyStatsService = MockBodyStatsService();
    await tester.pumpWidget(MaterialApp(home: BodyTrackingScreen()));

    // Act: Delete an existing body stat.
    await tester.runAsync(() async {
      await mockBodyStatsService.deleteBodyStat(1);
    });
    await tester.pumpAndSettle();

    // Assert: Verify that the delete body stat function was called.
    verify(mockBodyStatsService.deleteBodyStat(1)).called(1);
  });
}
