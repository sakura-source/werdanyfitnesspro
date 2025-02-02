import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/hormone_schedule_screen.dart';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([HormoneTrackerService])
void main() {
  testWidgets('Add Hormone button works', (WidgetTester tester) async {
    // Arrange: Set up the screen.
    await tester.pumpWidget(MaterialApp(home: HormoneScheduleScreen()));

    // Act: Tap the add hormone button.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Assert: Verify that the add hormone function was called.
    final mockHormoneTrackerService = MockHormoneTrackerService();
    verify(mockHormoneTrackerService.addHormone(any, any, any, any)).called(1);
  });

  testWidgets('Edit Hormone button works', (WidgetTester tester) async {
    // Arrange: Set up the screen with a hormone.
    final hormone = {'id': 1, 'name': 'Test Hormone', 'dosage': 10.0, 'schedule': 'Daily', 'purpose': 'Test'};
    final mockHormoneTrackerService = MockHormoneTrackerService();
    when(mockHormoneTrackerService.getHormones()).thenAnswer((_) async => [hormone]);
    await tester.pumpWidget(MaterialApp(home: HormoneScheduleScreen()));

    // Act: Tap the edit hormone button.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();

    // Assert: Verify that the edit hormone function was called.
    verify(mockHormoneTrackerService.editHormone(any, any, any, any, any)).called(1);
  });

  testWidgets('Delete Hormone button works', (WidgetTester tester) async {
    // Arrange: Set up the screen with a hormone.
    final hormone = {'id': 1, 'name': 'Test Hormone', 'dosage': 10.0, 'schedule': 'Daily', 'purpose': 'Test'};
    final mockHormoneTrackerService = MockHormoneTrackerService();
    when(mockHormoneTrackerService.getHormones()).thenAnswer((_) async => [hormone]);
    await tester.pumpWidget(MaterialApp(home: HormoneScheduleScreen()));

    // Act: Tap the delete hormone button.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Assert: Verify that the delete hormone function was called.
    verify(mockHormoneTrackerService.deleteHormone(any)).called(1);
  });
}
