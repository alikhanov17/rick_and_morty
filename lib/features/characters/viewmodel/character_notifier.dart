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
      // теперь getCharacters возвращает (List<Character>, bool isFromCache)
      final (newChars, isFromCache) = await repository.getCharacters(
        page: state.currentPage,
      );

      // если данные из кэша — выводим сообщение в консоль (а UI тоже сможет это отобразить)
      if (isFromCache) {
        print("📡 Работает офлайн — данные из кэша");
      } else {
        print("🌐 Загружено из сети");
      }

      state = state.copyWith(
        characters: [...state.characters, ...newChars],
        isLoading: false,
        hasError: false,
        currentPage: state.currentPage + 1,
        hasMore: newChars.isNotEmpty,
        // добавим флаг для UI, если оффлайн
        isOffline: isFromCache,
      );
    } on SocketException {
      print("❌ Нет соединения с интернетом. Попытка загрузить из кеша...");

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
          print("✅ Загружено из кеша");
        } else {
          throw Exception("Нет интернета и данных в кеше");
        }
      } catch (_) {
        state = state.copyWith(isLoading: false, hasError: true);
        print("⚠️ Ошибка: нет интернета и нет кеша");
      }
    } catch (e) {
      print("⚠️ Ошибка загрузки: $e");
      state = state.copyWith(isLoading: false, hasError: true);
    }
  }

  Future<void> refresh() async {
    state = const CharactersState();
    await loadCharacters();
  }
}
