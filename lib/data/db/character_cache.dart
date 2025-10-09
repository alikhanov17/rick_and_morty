import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/models/characters.dart';

class CharactersCache {
  static late Box _cacheBox;

  static Future<void> init() async {
    _cacheBox = await Hive.openBox('charactersCache');
  }

  static Future<void> saveCharacters(List<Character> characters) async {
    final data = characters.map((c) => c.toJson()).toList();
    await _cacheBox.put('cached_characters', data);
  }

  static List<Character> getCachedCharacters() {
    final data = _cacheBox.get('cached_characters');
    if (data == null) return [];
    return (data as List)
        .map((json) => Character.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}
