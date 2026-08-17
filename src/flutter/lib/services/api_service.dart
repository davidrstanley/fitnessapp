import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:fitnessapp/models/exercise_model.dart';

class WgerApiService {
  // Public wger API base URL
  static const String _url = 'https://wger.de/api/v2';

  Future<List<Exercise>> fetchExercises() async {
    final uri = Uri.parse('$_url/exerciseinfo/')
        .replace(queryParameters: {'language': '2', 'limit': '100'});
    final response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Decode the raw body text into a map
      final Map<String, dynamic> data = jsonDecode(response.body);

      final results = data['results'] as List<dynamic>? ?? [];

      return results
          .whereType<Map<String, dynamic>>()
          .map(Exercise.fromJson)
          .toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}
