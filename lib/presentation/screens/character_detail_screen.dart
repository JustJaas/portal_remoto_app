import 'package:flutter/material.dart';
import 'package:rick_morty_app/domain/character.dart';
import 'package:rick_morty_app/presentation/utils/character_utils.dart';
import 'package:rick_morty_app/presentation/widgets/character_image.dart';
import 'package:rick_morty_app/presentation/widgets/character_info_row.dart';
import 'package:rick_morty_app/presentation/widgets/status_dot.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: colorScheme.inverseSurface,
            foregroundColor: colorScheme.onInverseSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CharacterImage(url: character.image),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          colorScheme.scrim.withValues(alpha: 0),
                          colorScheme.scrim.withValues(alpha: 0.87),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    child: Text(
                      character.name,
                      style: textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onInverseSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      StatusDot(status: character.status, size: 10),
                      const SizedBox(width: 8),
                      Text(
                        character.status,
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          CharacterInfoRow(
                            label: 'Especie',
                            value: character.species,
                          ),
                          CharacterInfoRow(
                            label: 'Género',
                            value: character.gender,
                          ),
                          CharacterInfoRow(
                            label: 'Origen',
                            value: character.originName,
                          ),
                          CharacterInfoRow(
                            label: 'Última ubicación',
                            value: character.locationName,
                          ),
                          CharacterInfoRow(
                            label: 'ID',
                            value: '${character.id}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Resumen',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(CharacterUtils.summary(character)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
