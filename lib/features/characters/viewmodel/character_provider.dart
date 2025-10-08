import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/core/models/characters.dart';
import 'package:rick_and_morty/data/repositories/character_repository.dart';
import 'package:rick_and_morty/core/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
final characterRepositoryProvider = Provider<CharacterRepository>(
  (ref) => CharacterRepository(ref.read(apiServiceProvider)),
);

final charactersProvider = FutureProvider<List<Character>>((ref) async {
  return ref.read(characterRepositoryProvider).getCharacters();
});
