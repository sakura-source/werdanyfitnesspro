import 'package:firebase_database/firebase_database.dart';
import 'package:werdanyfitnesspro/models/diet_plan.dart';

class DietPlanService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('diet_plans');

  Future<List<DietPlan>> getDietPlans() async {
    final snapshot = await _databaseReference.once();
    final List<DietPlan> dietPlans = [];
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data = snapshot.value;
      data.forEach((key, value) {
        dietPlans.add(DietPlan.fromJson(Map<String, dynamic>.from(value)));
      });
    }
    return dietPlans;
  }

  Future<void> addDietPlan(DietPlan dietPlan) async {
    await _databaseReference.push().set(dietPlan.toJson());
  }

  Future<void> updateDietPlan(DietPlan dietPlan) async {
    await _databaseReference.child(dietPlan.id.toString()).update(dietPlan.toJson());
  }

  Future<void> deleteDietPlan(int id) async {
    await _databaseReference.child(id.toString()).remove();
  }

  Future<DietPlan?> getDietPlanById(int id) async {
    final snapshot = await _databaseReference.child(id.toString()).once();
    if (snapshot.value != null) {
      return DietPlan.fromJson(Map<String, dynamic>.from(snapshot.value));
    } else {
      return null;
    }
  }

  Future<DietPlan?> getLatestDietPlan() async {
    final snapshot = await _databaseReference.orderByKey().limitToLast(1).once();
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> data = snapshot.value;
      final key = data.keys.first;
      return DietPlan.fromJson(Map<String, dynamic>.from(data[key]));
    } else {
      return null;
    }
  }
}
