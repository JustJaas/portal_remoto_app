import 'package:rick_morty_app/data/api_exception.dart';
import 'package:rick_morty_app/data/character_model.dart';
import 'package:rick_morty_app/data/character_remote_datasource.dart';
import 'package:rick_morty_app/domain/character.dart';

class CharacterRepository {
  CharacterRepository(this._dataSource);

  final CharacterRemoteDataSource _dataSource;

  Future<List<Character>> getCharacters({String name = ''}) async {
    final List<Map<String, dynamic>> raw = await _dataSource.fetchCharacters(
      name: name,
    );

    try {
      return raw
          .map<Character>(
            (Map<String, dynamic> json) =>
                CharacterModel.fromJson(json).toEntity(),
          )
          .toList();
    } on TypeError {
      throw const ApiException(
        'Los datos recibidos tienen un formato inesperado.',
      );
    }
  }
}
