import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';

class ProgressPhotosScreen extends StatefulWidget {
  const ProgressPhotosScreen({super.key});

  @override
  _ProgressPhotosScreenState createState() => _ProgressPhotosScreenState();
}

class _ProgressPhotosScreenState extends State<ProgressPhotosScreen> {
  List<XFile> _photos = [];
  final ProgressPhotosService _progressPhotosService = ProgressPhotosService();

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final photos = await _progressPhotosService.getPhotos();
    setState(() {
      _photos = photos;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Photos'),
      ),
      body: Column(
        children: [
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
                  child: Image.file(
                    File(_photos[index].path),
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
              beforePhoto: _photos[_photos.length - 2],
              afterPhoto: _photos[_photos.length - 1],
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
        onTap: (index) {
          // Add navigation logic here
        },
      ),
    );
  }
}
