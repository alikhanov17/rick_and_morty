import 'package:rick_and_morty/core/models/characters.dart';
import 'package:rick_and_morty/core/services/api_service.dart';

class CharacterRepository {
  final ApiService apiService;

  CharacterRepository(this.apiService);

  Future<List<Character>> getCharacters({int page = 1}) {
    return apiService.fetchCharacters(page: page);
  }
}
