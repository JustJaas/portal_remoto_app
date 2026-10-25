import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rick_morty_app/data/api_exception.dart';

class CharacterRemoteDataSource {
  CharacterRemoteDataSource(this._client);

  final http.Client _client;

  static const String _host = 'rickandmortyapi.com';
  static const String _path = '/api/character';
  static const Duration _timeout = Duration(seconds: 10);

  Future<List<Map<String, dynamic>>> fetchCharacters({String name = ''}) async {
    final String query = name.trim();
    final Uri uri = Uri.https(
      _host,
      _path,
      query.isEmpty ? null : <String, String>{'name': query},
    );

    try {
      final http.Response response = await _client.get(uri).timeout(_timeout);

      if (response.statusCode == 404) {
        return <Map<String, dynamic>>[];
      }
      if (response.statusCode != 200) {
        throw ApiException(
          'El servidor respondió con un error (${response.statusCode}).',
        );
      }

      final Map<String, dynamic> body =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = body['results'] as List<dynamic>;
      return results.cast<Map<String, dynamic>>();
    } on TimeoutException {
      throw const ApiException(
        'La solicitud tardó demasiado. Intenta de nuevo.',
      );
    } on SocketException {
      throw const ApiException('Sin conexión a internet.');
    } on http.ClientException {
      throw const ApiException('No se pudo conectar con el servidor.');
    } on FormatException {
      throw const ApiException('La respuesta del servidor no es válida.');
    } on TypeError {
      throw const ApiException(
        'La respuesta del servidor tiene un formato inesperado.',
      );
    }
  }
}
