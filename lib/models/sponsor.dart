class Sponsor {
  final String id;
  final String name;
  final String logoUrl;
  final String websiteUrl;

  Sponsor({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.websiteUrl,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['id'],
      name: json['name'],
      logoUrl: json['logoUrl'],
      websiteUrl: json['websiteUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logoUrl': logoUrl,
      'websiteUrl': websiteUrl,
    };
  }
}
