import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/diet_plan_screen.dart';
import 'package:your_app/services/diet_plan_service.dart';
import 'package:your_app/models/diet_plan.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([DietPlanService])
void main() {
  testWidgets('Manage diet plans in DietPlanScreen', (WidgetTester tester) async {
    // Arrange: Set up the screen.
    await tester.pumpWidget(MaterialApp(home: DietPlanScreen()));

    // Act: Add a new diet plan.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert: Verify that the add diet plan function was called.
    final mockDietPlanService = MockDietPlanService();
    verify(mockDietPlanService.addDietPlan(any)).called(1);
  });
}
