import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty/core/models/characters.dart';
import 'package:rick_and_morty/data/db/favourite_storage.dart';

class FavoritesNotifier extends StateNotifier<List<Character>> {
  FavoritesNotifier() : super(FavoritesStorage.getAllFavorites());

  void toggleFavorite(Character character) {
    if (FavoritesStorage.isFavorite(character.id)) {
      FavoritesStorage.removeFromFavorites(character.id);
    } else {
      FavoritesStorage.addToFavorites(character);
    }
    state = FavoritesStorage.getAllFavorites();
  }

  bool isFavorite(int id) => FavoritesStorage.isFavorite(id);

  void sortByName() {
    final sorted = [...state]..sort((a, b) => a.name.compareTo(b.name));
    state = sorted;
  }

  void sortByStatus() {
    final sorted = [...state]..sort((a, b) => a.status.compareTo(b.status));
    state = sorted;
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Character>>(
      (ref) => FavoritesNotifier(),
    );
