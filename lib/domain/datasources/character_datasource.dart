import 'package:rick_morty_app/domain/entities/character.dart';
import 'package:rick_morty_app/domain/results/result.dart';

abstract class CharacterDataSourceInterface {
  Future<Result<List<Character>>> getCharacters({String name = ''});
}
