import 'package:rick_morty_app/domain/entities/character.dart';

class CharacterUtils {
  static String summary(Character character) {
    return '${character.name} es un personaje ${character.species.toLowerCase()} '
        'con estado ${character.status.toLowerCase()} '
        'y género ${character.gender.toLowerCase()}.';
  }
}
