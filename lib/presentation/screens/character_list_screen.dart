import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/presentation/providers/characters_provider.dart';
import 'package:rick_morty_app/presentation/screens/character_detail_screen.dart';
import 'package:rick_morty_app/presentation/widgets/character_grid.dart';
import 'package:rick_morty_app/presentation/widgets/character_search_field.dart';
import 'package:rick_morty_app/presentation/widgets/empty_view.dart';
import 'package:rick_morty_app/presentation/widgets/error_view.dart';

class CharacterListScreen extends ConsumerWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CharactersState state = ref.watch(charactersProvider);
    final CharactersNotifier notifier = ref.read(charactersProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: CharacterSearchField(onChanged: notifier.onQueryChanged),
          ),
          Expanded(
            child: switch (state.status) {
              CharactersStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              CharactersStatus.error => ErrorView(
                message: state.errorMessage,
                onRetry: notifier.retry,
              ),
              CharactersStatus.empty => EmptyView(query: state.query),
              CharactersStatus.success => CharacterGrid(
                characters: state.characters,
                onRefresh: notifier.refresh,
                onCharacterTap: (Character character) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          CharacterDetailScreen(character: character),
                    ),
                  );
                },
              ),
            },
          ),
        ],
      ),
    );
  }
}
