import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/progress_photos_screen.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ProgressPhotosService])
void main() {
  testWidgets('Upload Photo button works', (WidgetTester tester) async {
    // Arrange: Set up the screen.
    await tester.pumpWidget(MaterialApp(home: ProgressPhotosScreen()));

    // Act: Tap the upload photo button.
    await tester.tap(find.text('Upload Photo'));
    await tester.pump();

    // Assert: Verify that the photo upload function was called.
    final mockProgressPhotosService = MockProgressPhotosService();
    verify(mockProgressPhotosService.addPhoto(any)).called(1);
  });
}
