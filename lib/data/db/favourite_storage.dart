import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/models/characters.dart';

class FavoritesStorage {
  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('favorites');
  }

  static List<Character> getAllFavorites() {
    return _box.values
        .map((json) => Character.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  static bool isFavorite(int id) {
    return _box.containsKey(id);
  }

  static void addToFavorites(Character character) {
    _box.put(character.id, character.toJson());
  }

  static void removeFromFavorites(int id) {
    _box.delete(id);
  }
}
