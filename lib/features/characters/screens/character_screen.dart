import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/features/characters/viewmodel/character_provider.dart';
import 'package:rick_and_morty/utils/viewmodel/theme_provider.dart';
import '../widgets/character_card.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _shownOfflineMessage = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCharacters();
    });

    _scrollController.addListener(() {
      final state = ref.read(charactersNotifierProvider);
      if (!state.isLoading &&
          state.hasMore &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        ref.read(charactersNotifierProvider.notifier).loadCharacters();
      }
    });
  }

  Future<void> _loadCharacters() async {
    final notifier = ref.read(charactersNotifierProvider.notifier);

    try {
      await notifier.loadCharacters();
    } on SocketException {
      if (mounted && !_shownOfflineMessage) {
        _shownOfflineMessage = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Нет подключения к интернету. Загружаем из кеша.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка при загрузке данных.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final state = ref.watch(charactersNotifierProvider);
    final notifier = ref.read(charactersNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Персонажи'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.wb_sunny
                  : CupertinoIcons.moon_fill,
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (state.isOffline)
            Container(
              width: double.infinity,
              color: Colors.amber.withOpacity(0.2),
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Вы оффлайн — данные загружены из кеша',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _shownOfflineMessage = false;
                await notifier.refresh();
                await _loadCharacters();
              },
              child: Builder(
                builder: (context) {
                  if (state.isLoading && state.characters.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.hasError && state.characters.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Ошибка загрузки данных'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              await _loadCharacters();
                            },
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        state.characters.length + (state.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.characters.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final character = state.characters[index];
                      return CharacterCard(character: character);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
