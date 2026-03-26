enum Gender { male, female, genderless, unknown }

enum Status { alive, dead, unknown }

class CharacterModel {
  final int id;
  final String name;
  final Gender gender;
  final String species;
  final Status status;
  final String type;
  final String imagePath;
  final Map<String, dynamic> origin;
  final Map<String, dynamic> location;

  CharacterModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.species,
    required this.status,
    required this.type,
    required this.imagePath,
    required this.origin,
    required this.location,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      gender: Gender.values.firstWhere((element) {
        return element.name == (json['gender'] as String).toLowerCase();
      }, orElse: () => Gender.unknown),
      species: json['species'],
      status: Status.values.firstWhere((element) {
        return element.name == (json['status'] as String).toLowerCase();
      }, orElse: () => Status.unknown),
      type: json['type'],
      imagePath: json['image'],
      origin: Map<String, dynamic>.from(json['origin']),
      location: Map<String, dynamic>.from(json['location']),
    );
  }
}
