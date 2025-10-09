import 'dart:io';
import 'package:hive/hive.dart';
import 'package:rick_and_morty/core/models/characters.dart';
import 'package:rick_and_morty/core/services/api_service.dart';

class CharacterRepository {
  final ApiService apiService;
  late final Box _cacheBox;

  CharacterRepository(this.apiService) {
    _cacheBox = Hive.box('charactersCache');
  }

  Future<(List<Character>, bool isFromCache)> getCharacters({
    required int page,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      final hasConnection =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (hasConnection) {
        final characters = await apiService.fetchCharacters(page: page);

        await _cacheBox.put(
          'page_$page',
          characters.map((c) => c.toJson()).toList(),
        );

        return (characters, false); 
      } else {
        return _loadFromCache(page);
      }
    } catch (e) {
      return _loadFromCache(page);
    }
  }

  (List<Character>, bool) _loadFromCache(int page) {
    final cached = _cacheBox.get('page_$page');
    if (cached != null) {
      final characters = (cached as List)
          .map((json) => Character.fromJson(Map<String, dynamic>.from(json)))
          .toList();
      return (characters, true);
    }
    throw Exception('Нет интернета и нет данных в кэше');
  }
}
