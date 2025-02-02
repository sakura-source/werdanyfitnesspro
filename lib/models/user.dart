class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? phoneNumber;
  final int? age;
  final String gender;
  final double? height;
  final double? weight;
  final String goal;
  final String subscriptionStatus;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.age,
    required this.gender,
    this.height,
    this.weight,
    required this.goal,
    required this.subscriptionStatus,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      gender: json['gender'],
      height: json['height'],
      weight: json['weight'],
      goal: json['goal'],
      subscriptionStatus: json['subscription_status'],
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'goal': goal,
      'subscription_status': subscriptionStatus,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
