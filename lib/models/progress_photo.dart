class ProgressPhoto {
  int id;
  String photoPath;
  DateTime date;
  String notes;

  ProgressPhoto({
    required this.id,
    required this.photoPath,
    required this.date,
    required this.notes,
  });

  factory ProgressPhoto.fromJson(Map<String, dynamic> json) {
    return ProgressPhoto(
      id: json['id'],
      photoPath: json['photoPath'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photoPath': photoPath,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }
}
