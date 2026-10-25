import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_app/presentation/screens/character_list_screen.dart';
import 'package:rick_morty_app/presentation/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: PortalRemotoApp()));
}

class PortalRemotoApp extends StatelessWidget {
  const PortalRemotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Remoto',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const CharacterListScreen(),
    );
  }
}
