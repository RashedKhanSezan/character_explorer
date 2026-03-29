import 'package:hive/hive.dart';

part 'character_model.g.dart';

@HiveType(typeId: 1)
enum Status {
  @HiveField(0)
  alive,
  @HiveField(1)
  dead,
  @HiveField(2)
  unknown,
}

@HiveType(typeId: 2)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
  @HiveField(2)
  genderless,
  @HiveField(3)
  unknown,
}

class CharacterData {
  final int count;
  final int pages;
  final String next;
  final List<CharacterModel> allCharacter;

  CharacterData({
    required this.count,
    required this.pages,
    required this.allCharacter,
    required this.next,
  });

  factory CharacterData.fromJson(Map<String, dynamic> json) {
    return CharacterData(
      count: json['info']['count'] ?? 0,
      pages: json['info']['pages'] ?? 0,
      allCharacter: (json['results'] as List)
          .map((item) => CharacterModel.fromJson(item))
          .toList(),
      next: json['info']['next'] ?? '',
    );
  }
}

@HiveType(typeId: 0)
class CharacterModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final Gender gender;
  @HiveField(3)
  final String species;
  @HiveField(4)
  final Status status;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final String imagePath;
  @HiveField(7)
  final Map<dynamic, dynamic> origin;
  @HiveField(8)
  final Map<dynamic, dynamic> location;

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
      gender: Gender.values.firstWhere(
        (e) => e.name == (json['gender'] as String).toLowerCase(),
        orElse: () => Gender.unknown,
      ),
      species: json['species'],
      status: Status.values.firstWhere(
        (e) => e.name == (json['status'] as String).toLowerCase(),
        orElse: () => Status.unknown,
      ),
      type: json['type'] ?? '',
      imagePath: json['image'] ?? '',
      origin: Map<String, dynamic>.from(json['origin']),
      location: Map<String, dynamic>.from(json['location']),
    );
  }

  CharacterModel copyWith({
    String? name,
    Status? status,
    Gender? gender,
    String? species,
    String? type,
    String? originName,
    String? locationName,
  }) {
    return CharacterModel(
      id: id,
      imagePath: imagePath,
      name: name ?? this.name,
      status: status ?? this.status,
      gender: gender ?? this.gender,
      species: species ?? this.species,
      type: type ?? this.type,
      origin: originName != null ? {...origin, 'name': originName} : origin,
      location: locationName != null
          ? {...location, 'name': locationName}
          : location,
    );
  }
}
