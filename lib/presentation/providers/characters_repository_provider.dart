import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rick_morty_app/domain/datasources/character_datasource.dart';
import 'package:rick_morty_app/domain/repositories/character_repository.dart';
import 'package:rick_morty_app/infrastructure/datasources/character_remote_datasource.dart';
import 'package:rick_morty_app/infrastructure/repositories/character_repository_impl.dart';

final Provider<http.Client> httpClientProvider = Provider<http.Client>((
  Ref ref,
) {
  final http.Client client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final Provider<CharacterDataSourceInterface> characterDataSourceProvider =
    Provider<CharacterDataSourceInterface>(
      (Ref ref) => CharacterRemoteDataSource(ref.watch(httpClientProvider)),
    );

final Provider<CharacterRepositoryInterface> characterRepositoryProvider =
    Provider<CharacterRepositoryInterface>(
      (Ref ref) =>
          CharacterRepositoryImpl(ref.watch(characterDataSourceProvider)),
    );
