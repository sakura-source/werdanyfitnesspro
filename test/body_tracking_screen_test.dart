import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/body_tracking_screen.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([BodyStatsService])
void main() {
  testWidgets('Body stats are loaded and displayed', (WidgetTester tester) async {
    // Arrange: Set up the screen.
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
}
