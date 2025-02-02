import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:your_app/widgets/photo_comparison_widget.dart';
import 'dart:io';
import 'package:your_app/models/progress_photo.dart';

class ProgressPhotosScreen extends StatefulWidget {
  const ProgressPhotosScreen({Key? key}) : super(key: key);

  @override
  _ProgressPhotosScreenState createState() => _ProgressPhotosScreenState();
}

class _ProgressPhotosScreenState extends State<ProgressPhotosScreen> {
  List<ProgressPhoto> _photos = [];
  ProgressPhoto? _latestProgressPhoto;
  final ProgressPhotosService _progressPhotosService = ProgressPhotosService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final photos = await _progressPhotosService.getPhotos();
      final latestPhoto = await _progressPhotosService.getLatestProgressPhoto();
      setState(() {
        _photos = photos;
        _latestProgressPhoto = latestPhoto;
      });
    } catch (e) {
      _showErrorMessage('Error loading photos: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        await _progressPhotosService.addPhoto(photo);
        _loadPhotos();
      }
    } catch (e) {
      _showErrorMessage('Error picking photo: $e');
    }
  }

  void _deletePhoto(int id) async {
    try {
      await _progressPhotosService.deletePhoto(id);
      _loadPhotos();
    } catch (e) {
      _showErrorMessage('Error deleting photo: $e');
    }
  }

  void _navigateToScreen(int index) {
    final routes = [
      '/',
      '/body_tracking',
      '/diet_plan',
      '/hormone_schedule',
      '/progress_photos',
      '/trainer_dashboard',
    ];
    if (index >= 0 && index < routes.length) {
      Navigator.pushNamed(context, routes[index]);
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Photos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                          Image.network(
                            _latestProgressPhoto!.photoPath,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
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