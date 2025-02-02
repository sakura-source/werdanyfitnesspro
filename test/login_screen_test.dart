import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/login_screen.dart';
import 'package:your_app/services/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthService])
void main() {
  testWidgets('Login button triggers AuthService.login', (WidgetTester tester) async {
    // Arrange: Set up the screen.
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Act: Enter email and password, then tap the login button.
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert: Verify that the login function was called.
    final mockAuthService = MockAuthService();
    verify(mockAuthService.login('test@example.com', 'password')).called(1);
  });
}
