import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/data/db/favourite_storage.dart';
import 'features/home/home_page.dart';
import 'utils/app_theme.dart';
import 'utils/viewmodel/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await FavoritesStorage.init();

  runApp(const ProviderScope(child: RickAndMortyApp()));
}

class RickAndMortyApp extends ConsumerWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Rick and Morty',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
