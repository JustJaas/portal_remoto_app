import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_app/domain/errors/api_exception.dart';
import 'package:rick_morty_app/domain/entities/character.dart';
import 'package:rick_morty_app/domain/results/result.dart';
import 'package:rick_morty_app/presentation/providers/characters_repository_provider.dart';

final NotifierProvider<CharactersNotifier, CharactersState> charactersProvider =
    NotifierProvider<CharactersNotifier, CharactersState>(
      CharactersNotifier.new,
    );

class CharactersNotifier extends Notifier<CharactersState> {
  Timer? _debounce;
  int _requestId = 0;
  bool _disposed = false;

  @override
  CharactersState build() {
    ref.onDispose(() {
      _disposed = true;
      _debounce?.cancel();
    });

    Future<void>.microtask(() => _fetch(query: ''));
    return const CharactersState();
  }

  void onQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => _fetch(query: value),
    );
  }

  Future<void> retry() => _fetch(query: state.query);

  Future<void> refresh() => _fetch(query: state.query, showLoading: false);

  Future<void> _fetch({required String query, bool showLoading = true}) async {
    final int requestId = ++_requestId;

    if (showLoading) {
      state = state.copyWith(status: CharactersStatus.loading, query: query);
    }

    final Result<List<Character>> result = await ref
        .read(characterRepositoryProvider)
        .getCharacters(name: query);

    // Si el notifier murió o ya hay una petición más reciente, se descarta.
    if (_disposed || requestId != _requestId) {
      return;
    }

    // El switch es exhaustivo: si falta Success o Failure, no compila.
    switch (result) {
      case Success<List<Character>>(:final List<Character> data):
        state = state.copyWith(
          status: data.isEmpty
              ? CharactersStatus.empty
              : CharactersStatus.success,
          characters: data,
          query: query,
        );
      case Failure<List<Character>>(:final ApiException error):
        state = state.copyWith(
          status: CharactersStatus.error,
          errorMessage: error.message,
        );
    }
  }
}

enum CharactersStatus { loading, success, empty, error }

class CharactersState {
  const CharactersState({
    this.status = CharactersStatus.loading,
    this.characters = const <Character>[],
    this.query = '',
    this.errorMessage = '',
  });

  final CharactersStatus status;
  final List<Character> characters;
  final String query;
  final String errorMessage;

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    String? query,
    String? errorMessage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
