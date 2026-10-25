import 'package:rick_morty_app/domain/character.dart';

class CharacterModel {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? origin =
        json['origin'] as Map<String, dynamic>?;
    final Map<String, dynamic>? location =
        json['location'] as Map<String, dynamic>?;

    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Desconocido',
      status: json['status'] as String? ?? 'unknown',
      species: json['species'] as String? ?? 'unknown',
      gender: json['gender'] as String? ?? 'unknown',
      originName: origin?['name'] as String? ?? 'unknown',
      locationName: location?['name'] as String? ?? 'unknown',
      image: json['image'] as String? ?? '',
    );
  }

  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String originName;
  final String locationName;
  final String image;

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      gender: gender,
      originName: originName,
      locationName: locationName,
      image: image,
    );
  }
}
