import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/core/models/characters.dart';
import 'package:rick_and_morty/features/favourites/viewmodel/favourite_provider.dart';

class CharacterCard extends ConsumerWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favorites = ref.watch(favoritesProvider);
    final isFavorite = favorites.any((c) => c.id == character.id);

    final statusColor = switch (character.status.toLowerCase()) {
      'alive' => Colors.green,
      'dead' => Colors.red,
      _ => Colors.grey,
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                character.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.circle, color: statusColor, size: 10),
                      const SizedBox(width: 6),
                      Text('${character.status} • ${character.species}'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('Пол: ${character.gender}'),
                  Text('происхождение: ${character.origin}'),
                  Text('Локация: ${character.location}'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                color: isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: () {
                ref.read(favoritesProvider.notifier).toggleFavorite(character);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFavorite ? 'Удалено' : 'Сохранено в избранное',
                    ),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
