class Settings {
  final int id;
  final int userId;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String preferredWorkoutType;
  final String language;
  final DateTime? goalDeadline;
  final DateTime createdAt;
  final DateTime updatedAt;

  Settings({
    required this.id,
    required this.userId,
    required this.notificationsEnabled,
    required this.darkModeEnabled,
    required this.preferredWorkoutType,
    required this.language,
    this.goalDeadline,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      userId: json['user_id'],
      notificationsEnabled: json['notifications_enabled'],
      darkModeEnabled: json['dark_mode_enabled'],
      preferredWorkoutType: json['preferred_workout_type'],
      language: json['language'],
      goalDeadline: json['goal_deadline'] != null ? DateTime.parse(json['goal_deadline']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'notifications_enabled': notificationsEnabled,
      'dark_mode_enabled': darkModeEnabled,
      'preferred_workout_type': preferredWorkoutType,
      'language': language,
      'goal_deadline': goalDeadline?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
