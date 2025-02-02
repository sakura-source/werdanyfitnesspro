import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:your_app/models/progress_photo.dart';

class ProgressPhotosService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference().child('progress_photos');

  Future<List<ProgressPhoto>> getPhotos() async {
    final snapshot = await _database.once();
    final List<ProgressPhoto> photos = [];
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data = snapshot.value;
      data.forEach((key, value) {
        photos.add(ProgressPhoto.fromJson(Map<String, dynamic>.from(value)));
      });
    }
    return photos;
  }

  Future<void> addPhoto(XFile photo) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final File file = File(photo.path);
    final StorageReference storageRef = _storage.ref().child('progress_photos/$fileName');
    final StorageUploadTask uploadTask = storageRef.putFile(file);
    final StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    final ProgressPhoto progressPhoto = ProgressPhoto(
      id: fileName.hashCode,
      photoPath: downloadUrl,
      date: DateTime.now(),
      notes: '',
    );

    await _database.child(fileName).set(progressPhoto.toJson());
  }

  Future<void> deletePhoto(int id) async {
    final snapshot = await _database.orderByChild('id').equalTo(id).once();
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data = snapshot.value;
      data.forEach((key, value) async {
        final String photoPath = value['photoPath'];
        final StorageReference storageRef = await _storage.getReferenceFromUrl(photoPath);
        await storageRef.delete();
        await _database.child(key).remove();
      });
    }
  }

  Future<ProgressPhoto?> getProgressPhotoById(int id) async {
    final snapshot = await _database.orderByChild('id').equalTo(id).once();
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data = snapshot.value;
      final key = data.keys.first;
      return ProgressPhoto.fromJson(Map<String, dynamic>.from(data[key]));
    } else {
      return null;
    }
  }

  Future<ProgressPhoto?> getLatestProgressPhoto() async {
    final snapshot = await _database.orderByKey().limitToLast(1).once();
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data = snapshot.value;
      final key = data.keys.first;
      return ProgressPhoto.fromJson(Map<String, dynamic>.from(data[key]));
    } else {
      return null;
    }
  }
}
