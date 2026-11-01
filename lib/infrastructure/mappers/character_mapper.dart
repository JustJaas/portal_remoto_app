import 'package:rick_morty_app/domain/entities/character.dart';
import 'package:rick_morty_app/infrastructure/models/character_model.dart';

class CharacterMapper {
  static Character modelToEntity(CharacterModel model) {
    return Character(
      id: model.id,
      name: model.name,
      status: model.status,
      species: model.species,
      gender: model.gender,
      originName: model.originName,
      locationName: model.locationName,
      image: model.image,
    );
  }
}
