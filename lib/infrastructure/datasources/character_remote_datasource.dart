import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_morty_app/domain/datasources/character_datasource.dart';
import 'package:rick_morty_app/domain/entities/character.dart';
import 'package:rick_morty_app/domain/errors/api_exception.dart';
import 'package:rick_morty_app/domain/results/result.dart';
import 'package:rick_morty_app/infrastructure/mappers/character_mapper.dart';
import 'package:rick_morty_app/infrastructure/models/character_model.dart';

class CharacterRemoteDataSource implements CharacterDataSourceInterface {
  CharacterRemoteDataSource(this._client);

  final http.Client _client;

  static const String _host = 'rickandmortyapi.com';
  static const String _path = '/api/character';
  static const Duration _timeout = Duration(seconds: 10);

  @override
  Future<Result<List<Character>>> getCharacters({String name = ''}) async {
    final String query = name.trim();
    final Uri uri = Uri.https(
      _host,
      _path,
      query.isEmpty ? null : <String, String>{'name': query},
    );

    try {
      final http.Response response = await _client.get(uri).timeout(_timeout);

      if (response.statusCode == 404) {
        return Success<List<Character>>(<Character>[]);
      }
      if (response.statusCode != 200) {
        return _failure(
          'El servidor respondió con un error (${response.statusCode}).',
        );
      }

      final Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = body['results'] as List<dynamic>;

      final List<Character> characters = results
          .map<Character>(
            (dynamic item) => CharacterMapper.modelToEntity(
              CharacterModel.fromJson(item as Map<String, dynamic>),
            ),
          )
          .toList();

      return Success<List<Character>>(characters);
    } on TimeoutException {
      return _failure('La solicitud tardó demasiado. Intenta de nuevo.');
    } on SocketException {
      return _failure('Sin conexión a internet.');
    } on http.ClientException {
      return _failure('No se pudo conectar con el servidor.');
    } on FormatException {
      return _failure('La respuesta del servidor no es válida.');
    } on TypeError {
      return _failure('La respuesta del servidor tiene un formato inesperado.');
    } catch (_) {
      return _failure('Ocurrió un error inesperado.');
    }
  }

  Failure<List<Character>> _failure(String message) {
    return Failure<List<Character>>(ApiException(message));
  }
}
