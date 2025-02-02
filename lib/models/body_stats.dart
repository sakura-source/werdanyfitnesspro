class BodyStats {
  int id;
  double weight;
  double muscleMass;
  double fatPercentage;
  DateTime date;
  double height;
  double bmi;
  double waistCircumference;

  BodyStats({
    required this.id,
    required this.weight,
    required this.muscleMass,
    required this.fatPercentage,
    required this.date,
    required this.height,
    required this.bmi,
    required this.waistCircumference,
  });

  factory BodyStats.fromJson(Map<String, dynamic> json) {
    try {
      return BodyStats(
        id: json['id'],
        weight: json['weight'],
        muscleMass: json['muscleMass'],
        fatPercentage: json['fatPercentage'],
        date: DateTime.parse(json['date']),
        height: json['height'],
        bmi: json['bmi'],
        waistCircumference: json['waistCircumference'],
      );
    } catch (e) {
      throw Exception('Error parsing JSON: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'muscleMass': muscleMass,
      'fatPercentage': fatPercentage,
      'date': date.toIso8601String(),
      'height': height,
      'bmi': bmi,
      'waistCircumference': waistCircumference,
    };
  }

  bool validate() {
    if (weight < 0 || weight > 500) return false;
    if (muscleMass < 0 || muscleMass > 100) return false;
    if (fatPercentage < 0 || fatPercentage > 100) return false;
    return true;
  }

  String formatDate() {
    return '${date.day}/${date.month}/${date.year}';
  }

  String timeSinceRecorded() {
    final duration = DateTime.now().difference(date);
    if (duration.inDays > 0) {
      return '${duration.inDays} days ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hours ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
