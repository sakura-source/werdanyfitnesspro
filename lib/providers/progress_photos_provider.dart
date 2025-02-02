import 'package:flutter/material.dart';
import 'package:your_app/models/progress_photo.dart';

class ProgressPhotosProvider with ChangeNotifier {
  List<ProgressPhoto> _photos = [];

  List<ProgressPhoto> get photos => _photos;

  void setPhotos(List<ProgressPhoto> photos) {
    _photos = photos;
    notifyListeners();
  }

  void addPhoto(ProgressPhoto photo) {
    _photos.add(photo);
    notifyListeners();
  }

  void removePhoto(int id) {
    _photos.removeWhere((photo) => photo.id == id);
    notifyListeners();
  }
}
