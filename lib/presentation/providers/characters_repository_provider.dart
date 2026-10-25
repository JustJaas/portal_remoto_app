import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_app/data/character_remote_datasource.dart';
import 'package:rick_morty_app/data/character_repository.dart';

final Provider<http.Client> httpClientProvider = Provider<http.Client>((
  Ref ref,
) {
  final http.Client client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final Provider<CharacterRemoteDataSource> characterRemoteDataSourceProvider =
    Provider<CharacterRemoteDataSource>(
      (Ref ref) => CharacterRemoteDataSource(ref.watch(httpClientProvider)),
    );

final Provider<CharacterRepository> characterRepositoryProvider =
    Provider<CharacterRepository>(
      (Ref ref) =>
          CharacterRepository(ref.watch(characterRemoteDataSourceProvider)),
    );
