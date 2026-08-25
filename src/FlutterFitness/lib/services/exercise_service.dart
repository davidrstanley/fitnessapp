import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/exercise.dart';

class ExerciseService {
  Future<List<Exercise>> loadExercises() async {
    final String jsonString = await rootBundle.loadString('assets/exercises.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    
    return jsonList.map((json) {
      return Exercise.fromJson(json);
    }).toList();
  }

  Future<List<Exercise>> getFilteredExercises({
    required String targetEquipment,
    required String targetLevel,
    required int exerciseCount,
  }) async {
    List<Exercise> allExercises = await loadExercises();

    List<Exercise> filteredList = allExercises.where((exercise) {
      bool matchesEquipment = exercise.equipment.toLowerCase() == targetEquipment.toLowerCase();
      bool matchesLevel = exercise.level.toLowerCase() == targetLevel.toLowerCase();
      
      return matchesEquipment && matchesLevel;
    }).toList();

    filteredList.shuffle();

    return filteredList.take(exerciseCount).toList();
  }
}