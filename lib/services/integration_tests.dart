import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/services/body_stats_service.dart';
import 'package:your_app/services/diet_plan_service.dart';
import 'package:your_app/services/progress_photos_service.dart';
import 'package:your_app/services/trainer_profile_service.dart';
import 'package:your_app/models/body_stats.dart';
import 'package:your_app/models/diet_plan.dart';
import 'package:your_app/models/progress_photo.dart';
import 'package:your_app/models/trainer_profile.dart';

void main() {
  group('Integration Tests', () {
    final bodyStatsService = BodyStatsService();
    final dietPlanService = DietPlanService();
    final progressPhotosService = ProgressPhotosService();
    final trainerProfileService = TrainerProfileService();

    test('Add and retrieve body stat', () async {
      final bodyStat = BodyStats(
        id: 1,
        weight: 70.0,
        muscleMass: 30.0,
        fatPercentage: 20.0,
        date: DateTime.now().toIso8601String(),
        height: 175.0,
        bmi: 22.9,
        waistCircumference: 80.0,
      );
      await bodyStatsService.addBodyStat(bodyStat);
      final retrievedBodyStat = await bodyStatsService.getLatestBodyStat();
      expect(retrievedBodyStat, isNotNull);
      expect(retrievedBodyStat!.weight, 70.0);
    });

    test('Add and retrieve diet plan', () async {
      final dietPlan = DietPlan(
        id: 1,
        name: 'Keto Diet',
        calories: 2000,
        protein: 150,
        carbs: 50,
        fats: 100,
      );
      await dietPlanService.addDietPlan(dietPlan);
      final retrievedDietPlan = await dietPlanService.getLatestDietPlan();
      expect(retrievedDietPlan, isNotNull);
      expect(retrievedDietPlan!.name, 'Keto Diet');
    });

    test('Add and retrieve progress photo', () async {
      final progressPhoto = ProgressPhoto(
        id: 1,
        photoPath: 'path/to/photo.jpg',
        date: DateTime.now(),
        notes: 'First progress photo',
      );
      await progressPhotosService.addPhoto(progressPhoto);
      final retrievedProgressPhoto = await progressPhotosService.getLatestProgressPhoto();
      expect(retrievedProgressPhoto, isNotNull);
      expect(retrievedProgressPhoto!.photoPath, 'path/to/photo.jpg');
    });

    test('Add and retrieve trainer profile', () async {
      final trainerProfile = TrainerProfile(
        id: 1,
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '1234567890',
        address: '123 Main St',
        clients: 'Client1, Client2',
      );
      await trainerProfileService.addClient(trainerProfile);
      final retrievedTrainerProfile = await trainerProfileService.getLatestClient();
      expect(retrievedTrainerProfile, isNotNull);
      expect(retrievedTrainerProfile!.name, 'John Doe');
    });

    test('Integration test: Add body stat and retrieve diet plan', () async {
      final bodyStat = BodyStats(
        id: 2,
        weight: 75.0,
        muscleMass: 32.0,
        fatPercentage: 18.0,
        date: DateTime.now().toIso8601String(),
        height: 180.0,
        bmi: 23.1,
        waistCircumference: 82.0,
      );
      await bodyStatsService.addBodyStat(bodyStat);
      final dietPlan = DietPlan(
        id: 2,
        name: 'Paleo Diet',
        calories: 2500,
        protein: 200,
        carbs: 100,
        fats: 120,
      );
      await dietPlanService.addDietPlan(dietPlan);
      final retrievedDietPlan = await dietPlanService.getLatestDietPlan();
      expect(retrievedDietPlan, isNotNull);
      expect(retrievedDietPlan!.name, 'Paleo Diet');
    });

    test('Integration test: Add progress photo and retrieve trainer profile', () async {
      final progressPhoto = ProgressPhoto(
        id: 2,
        photoPath: 'path/to/second_photo.jpg',
        date: DateTime.now(),
        notes: 'Second progress photo',
      );
      await progressPhotosService.addPhoto(progressPhoto);
      final trainerProfile = TrainerProfile(
        id: 2,
        name: 'Jane Smith',
        email: 'jane.smith@example.com',
        phone: '0987654321',
        address: '456 Elm St',
        clients: 'Client3, Client4',
      );
      await trainerProfileService.addClient(trainerProfile);
      final retrievedTrainerProfile = await trainerProfileService.getLatestClient();
      expect(retrievedTrainerProfile, isNotNull);
      expect(retrievedTrainerProfile!.name, 'Jane Smith');
    });
  });
}
