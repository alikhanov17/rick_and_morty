import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/models/characters.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api/'),
  );
  Future<List<Character>> fetchCharacters({required int page}) async {
    try {
      final response = await _dio.get(
        'character',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final results = response.data['results'];

        return (results as List)
            .map((json) => Character.fromJson(json))
            .toList();
      } else {
        throw Exception('Не удалось загрузить персонажей');
      }
    } catch (e) {
      print('❌ Ошибка при загрузке персонажей: $e');
      rethrow;
    }
  }
}
