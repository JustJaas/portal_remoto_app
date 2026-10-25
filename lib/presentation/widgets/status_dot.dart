import 'package:flutter/material.dart';

class StatusDot extends StatelessWidget {
  const StatusDot({super.key, required this.status, this.size = 9});

  final String status;
  final double size;

  Color _colorFor(ColorScheme colorScheme) {
    switch (status.toLowerCase()) {
      case 'alive':
        return colorScheme.primary;
      case 'dead':
        return colorScheme.error;
      default:
        return colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _colorFor(colorScheme),
        shape: BoxShape.circle,
      ),
    );
  }
}
