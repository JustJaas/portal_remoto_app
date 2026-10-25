import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent? progress) {
            if (progress == null) {
              return child;
            }
            return ColoredBox(
              color: colorScheme.surfaceContainerHighest,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
            return ColoredBox(
              color: colorScheme.surfaceContainerHighest,
              child: const Center(
                child: Icon(Icons.broken_image_outlined, size: 32),
              ),
            );
          },
    );
  }
}
