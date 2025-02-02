import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';
import 'dart:io';
import 'package:your_app/models/progress_photo.dart';
import 'package:flutter_test/flutter_test.dart';

class ProgressPhotosScreen extends StatefulWidget {
  const ProgressPhotosScreen({super.key});

  @override
  _ProgressPhotosScreenState createState() => _ProgressPhotosScreenState();
}

class _ProgressPhotosScreenState extends State<ProgressPhotosScreen> {
  List<ProgressPhoto> _photos = [];
  ProgressPhoto? _latestProgressPhoto;
  final ProgressPhotosService _progressPhotosService = ProgressPhotosService();

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final photos = await _progressPhotosService.getPhotos();
    final latestPhoto = await _progressPhotosService.getLatestProgressPhoto();
    setState(() {
      _photos = photos;
      _latestProgressPhoto = latestPhoto;
    });
  }

  Future<void> _pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      await _progressPhotosService.addPhoto(photo);
      _loadPhotos();
    }
  }

  void _deletePhoto(int id) async {
    await _progressPhotosService.deletePhoto(id);
    _loadPhotos();
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/body_tracking');
        break;
      case 2:
        Navigator.pushNamed(context, '/diet_plan');
        break;
      case 3:
        Navigator.pushNamed(context, '/hormone_schedule');
        break;
      case 4:
        Navigator.pushNamed(context, '/progress_photos');
        break;
      case 5:
        Navigator.pushNamed(context, '/trainer_dashboard');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Photos'),
      ),
      body: Column(
        children: [
          if (_latestProgressPhoto != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Latest Progress Photo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.network(_latestProgressPhoto!.photoPath),
                  ],
                ),
              ),
            ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _deletePhoto(_photos[index].id),
                  child: Image.network(
                    _photos[index].photoPath,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _pickPhoto,
            child: const Text('Upload Photo'),
          ),
          if (_photos.length >= 2)
            PhotoComparisonWidget(
              beforePhoto: _photos[_photos.length - 2].photoPath,
              afterPhoto: _photos[_photos.length - 1].photoPath,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Body Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Diet Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Hormone Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Progress Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Trainer Dashboard',
          ),
        ],
        currentIndex: 4,
        selectedItemColor: Colors.blue,
        onTap: _navigateToScreen,
      ),
    );
  }
}

void main() {
  testWidgets('ProgressPhotosScreen displays progress photos and interacts with buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProgressPhotosScreen()));

    // Verify the display of progress photos
    expect(find.text('Progress Photos'), findsOneWidget);
    expect(find.text('Latest Progress Photo'), findsOneWidget);

    // Verify interaction with buttons
    expect(find.text('Upload Photo'), findsOneWidget);
    await tester.tap(find.text('Upload Photo'));
    await tester.pump();

    // Add more test cases as needed
  });
}
