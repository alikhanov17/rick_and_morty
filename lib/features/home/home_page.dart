import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/screens/character_screen.dart';
import 'package:rick_and_morty/features/characters/screens/favourite_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _screens = const [CharactersScreen(), FavoritesScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Список Персонажев',
          ),
          NavigationDestination(icon: Icon(Icons.star), label: 'Избранное'),
        ],
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
