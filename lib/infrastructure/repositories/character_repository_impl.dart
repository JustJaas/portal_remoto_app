import 'package:rick_morty_app/domain/datasources/character_datasource.dart';
import 'package:rick_morty_app/domain/entities/character.dart';
import 'package:rick_morty_app/domain/repositories/character_repository.dart';
import 'package:rick_morty_app/domain/results/result.dart';

class CharacterRepositoryImpl implements CharacterRepositoryInterface {
  CharacterRepositoryImpl(this._dataSource);

  final CharacterDataSourceInterface _dataSource;

  @override
  Future<Result<List<Character>>> getCharacters({String name = ''}) {
    return _dataSource.getCharacters(name: name);
  }
}
