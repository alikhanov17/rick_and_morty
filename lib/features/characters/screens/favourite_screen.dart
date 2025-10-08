import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/features/characters/widgets/character_card.dart';
import 'package:rick_and_morty/features/favourites/viewmodel/favourite_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    if (favorites.isEmpty) {
      return const Center(child: Text('Пусто'));
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final c = favorites[index];
        return CharacterCard(character: c);
      },
    );
  }
}
