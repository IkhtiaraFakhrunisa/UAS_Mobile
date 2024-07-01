// models/character.dart
class Character {
  final String name;
  final String house;
  final String actor;
  final String ancestry;
  final String image;

  Character({
    required this.name,
    required this.house,
    required this.actor,
    required this.ancestry,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'],
      house: json['house'],
      actor: json['actor'],
      ancestry: json['ancestry'],
      image: json['image'],
    );
  }
}
