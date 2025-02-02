import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:your_app/models/exercise.dart';
import 'package:your_app/models/sponsor.dart';
import 'package:your_app/models/progress_photo.dart';
import 'package:your_app/models/trainer_profile.dart';

class ApiService {
  static const String baseUrl = 'https://api.example.com';

  Future<List<Exercise>> fetchExercises() async {
    final response = await http.get(Uri.parse('$baseUrl/exercises'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }

  Future<List<Sponsor>> fetchSponsors() async {
    final response = await http.get(Uri.parse('$baseUrl/sponsors'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Sponsor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sponsors');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProgressPhoto>> fetchProgressPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/progress_photos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProgressPhoto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load progress photos');
    }
  }

  Future<List<TrainerProfile>> fetchClients() async {
    final response = await http.get(Uri.parse('$baseUrl/clients'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => TrainerProfile.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load clients');
    }
  }
}
