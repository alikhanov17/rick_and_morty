class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String origin;
  final String location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] is int ? json['id'] : 0,
      name: json['name']?.toString() ?? 'Unknown',
      status: json['status']?.toString() ?? 'Unknown',
      species: json['species']?.toString() ?? 'Unknown',
      gender: json['gender']?.toString() ?? 'Unknown',
      image: json['image']?.toString() ?? '',
      origin: (json['origin'] != null && json['origin'] is Map)
          ? (json['origin']['name']?.toString() ?? 'Unknown')
          : 'Unknown',
      location: (json['location'] != null && json['location'] is Map)
          ? (json['location']['name']?.toString() ?? 'Unknown')
          : 'Unknown',
    );
  }

  /// 👇 Вот этот метод решает твою проблему
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image,
      'origin': origin,
      'location': location,
    };
  }
}
