import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/presentation/widgets/character_card.dart';

class CharacterGrid extends StatelessWidget {
  const CharacterGrid({
    super.key,
    required this.characters,
    required this.onRefresh,
    required this.onCharacterTap,
  });

  final List<Character> characters;
  final RefreshCallback onRefresh;
  final ValueChanged<Character> onCharacterTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          final Character character = characters[index];
          return CharacterCard(
            character: character,
            onTap: () => onCharacterTap(character),
          );
        },
      ),
    );
  }
}
