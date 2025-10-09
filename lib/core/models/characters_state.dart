import 'package:rick_and_morty/core/models/characters.dart';

class CharactersState {
  final List<Character> characters;
  final bool isLoading;
  final bool hasError;
  final int currentPage;
  final bool hasMore;
  final bool isOffline; 

  const CharactersState({
    this.characters = const [],
    this.isLoading = false,
    this.hasError = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.isOffline = false,
  });

  CharactersState copyWith({
    List<Character>? characters,
    bool? isLoading,
    bool? hasError,
    int? currentPage,
    bool? hasMore,
    bool? isOffline, 
  }) {
    return CharactersState(
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isOffline: isOffline ?? this.isOffline, 
    );
  }
}
