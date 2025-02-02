import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/screens/progress_photos_screen.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:your_app/models/progress_photo.dart';

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

  testWidgets('Load photos on init', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockProgressPhotosService = MockProgressPhotosService();
    when(mockProgressPhotosService.getPhotos()).thenAnswer((_) async => [
      ProgressPhoto(id: 1, photoPath: 'path1', date: DateTime.now(), notes: 'note1'),
      ProgressPhoto(id: 2, photoPath: 'path2', date: DateTime.now(), notes: 'note2'),
    ]);
    await tester.pumpWidget(MaterialApp(home: ProgressPhotosScreen()));

    // Act: Wait for the photos to load.
    await tester.pumpAndSettle();

    // Assert: Verify that the photos are displayed.
    expect(find.byType(Image), findsNWidgets(2));
  });

  testWidgets('Delete photo on long press', (WidgetTester tester) async {
    // Arrange: Set up the mock service and screen.
    final mockProgressPhotosService = MockProgressPhotosService();
    when(mockProgressPhotosService.getPhotos()).thenAnswer((_) async => [
      ProgressPhoto(id: 1, photoPath: 'path1', date: DateTime.now(), notes: 'note1'),
    ]);
    await tester.pumpWidget(MaterialApp(home: ProgressPhotosScreen()));

    // Act: Long press the photo to delete it.
    await tester.longPress(find.byType(Image));
    await tester.pumpAndSettle();

    // Assert: Verify that the delete function was called.
    verify(mockProgressPhotosService.deletePhoto(1)).called(1);
  });
}
