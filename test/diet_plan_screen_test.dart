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

  testWidgets('Load diet plans on init', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockDietPlanService = MockDietPlanService();
    when(mockDietPlanService.getDietPlans()).thenAnswer((_) async => [
      DietPlan(id: 1, name: 'Plan 1', calories: 2000, protein: 150, carbs: 250, fats: 70),
      DietPlan(id: 2, name: 'Plan 2', calories: 1800, protein: 130, carbs: 220, fats: 60),
    ]);
    await tester.pumpWidget(MaterialApp(home: DietPlanScreen()));

    // Act: Wait for the diet plans to load.
    await tester.pumpAndSettle();

    // Assert: Verify that the diet plans are displayed.
    expect(find.byType(DietCard), findsNWidgets(2));
  });

  testWidgets('Delete diet plan on delete button press', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockDietPlanService = MockDietPlanService();
    when(mockDietPlanService.getDietPlans()).thenAnswer((_) async => [
      DietPlan(id: 1, name: 'Plan 1', calories: 2000, protein: 150, carbs: 250, fats: 70),
    ]);
    await tester.pumpWidget(MaterialApp(home: DietPlanScreen()));

    // Act: Press the delete button to delete the diet plan.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Assert: Verify that the delete function was called.
    verify(mockDietPlanService.deleteDietPlan(1)).called(1);
  });
}
