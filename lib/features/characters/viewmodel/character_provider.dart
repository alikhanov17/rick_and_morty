import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:rick_and_morty/core/models/characters_state.dart';
import 'package:rick_and_morty/core/services/api_service.dart';
import 'package:rick_and_morty/data/repositories/character_repository.dart';
import 'package:rick_and_morty/features/characters/viewmodel/character_notifier.dart';

// Провайдер для ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Провайдер для репозитория
final characterRepositoryProvider = Provider<CharacterRepository>(
  (ref) => CharacterRepository(ref.read(apiServiceProvider)),
);

// Провайдер для StateNotifier
final charactersNotifierProvider =
    StateNotifierProvider<CharactersNotifier, CharactersState>((ref) {
      final repository = ref.read(characterRepositoryProvider);
      return CharactersNotifier(repository);
    });
