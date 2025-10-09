import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty/core/models/characters_state.dart';
import 'package:rick_and_morty/data/repositories/character_repository.dart';

class CharactersNotifier extends StateNotifier<CharactersState> {
  final CharacterRepository repository;

  CharactersNotifier(this.repository) : super(const CharactersState());

  Future<void> loadCharacters() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, hasError: false);

    try {
      final (newChars, isFromCache) = await repository.getCharacters(
        page: state.currentPage,
      );

    

      state = state.copyWith(
        characters: [...state.characters, ...newChars],
        isLoading: false,
        hasError: false,
        currentPage: state.currentPage + 1,
        hasMore: newChars.isNotEmpty,
        isOffline: isFromCache,
      );
    } on SocketException {

      try {
        final (cached, _) = await repository.getCharacters(
          page: state.currentPage,
        );
        if (cached.isNotEmpty) {
          state = state.copyWith(
            characters: [...state.characters, ...cached],
            isLoading: false,
            hasError: false,
            isOffline: true,
          );
        } else {
          throw Exception("Нет интернета и данных в кеше");
        }
      } catch (_) {
        state = state.copyWith(isLoading: false, hasError: true);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, hasError: true);
    }
  }

  Future<void> refresh() async {
    state = const CharactersState();
    await loadCharacters();
  }
}
