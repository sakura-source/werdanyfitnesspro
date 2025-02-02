import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/trainer_dashboard_screen.dart';
import 'package:your_app/services/trainer_profile_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([TrainerProfileService])
void main() {
  testWidgets('Manage clients in TrainerDashboardScreen', (WidgetTester tester) async {
    // Arrange: Set up the screen.
    await tester.pumpWidget(MaterialApp(home: TrainerDashboardScreen()));

    // Act: Add a new client.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert: Verify that the add client function was called.
    final mockTrainerProfileService = MockTrainerProfileService();
    verify(mockTrainerProfileService.addClient(any)).called(1);
  });
}
