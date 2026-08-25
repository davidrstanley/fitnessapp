import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../services/exercise_service.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExerciseService exerciseService = ExerciseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Custom Workout'),
      ),
      body: FutureBuilder<List<Exercise>>(
        future: exerciseService.getFilteredExercises(
          targetEquipment: 'body only',
          targetLevel: 'beginner',
          exerciseCount: 4,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final List<Exercise>? exercises = snapshot.data;
          
          if (exercises == null || exercises.isEmpty) {
            return const Center(child: Text('No exercises found!'));
          }

          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    exercise.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${exercise.category} • ${exercise.equipment}'),
                  trailing: Text(
                    exercise.level.toUpperCase(),
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}