import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/features/characters/viewmodel/character_provider.dart';
import 'package:rick_and_morty/utils/viewmodel/theme_provider.dart';
import '../widgets/character_card.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsync = ref.watch(charactersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Персонажи'),
        actions: [
          IconButton(
            icon: Icon(
              ref.watch(themeProvider) == ThemeMode.dark
                  ? Icons.wb_sunny
                  : CupertinoIcons.moon_fill,
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: charactersAsync.when(
        data: (characters) {
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final c = characters[index];
              return CharacterCard(character: c);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
