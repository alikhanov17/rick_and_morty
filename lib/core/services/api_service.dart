import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/models/characters.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'),
  );

  Future<List<Character>> fetchCharacters({int page = 1}) async {
    final response = await _dio.get(
      'character',
      queryParameters: {'page': page},
    );

    if (response.statusCode == 200) {
      final results = response.data['results'] as List;
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
