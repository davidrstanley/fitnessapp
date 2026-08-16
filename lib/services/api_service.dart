import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:fitnessapp/models/exercise_model.dart';

class WgerApiService {
  // Public wger API endpoint for exercises
  static const String _url =
      'https://wger.de/api/v2/exercise/?language=2'; // Language 2 = English

  Future<List<Exercise>> fetchExercises() async {
    final response = await http.get(
      Uri.parse(_url),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Decode the raw body text into a map
      final Map<String, dynamic> data = jsonDecode(response.body);

      // The wger API returns arrays inside a 'results' key
      final List<dynamic> results = data['results'];

      // Map each item in the array to our Exercise model
      return results.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
}
