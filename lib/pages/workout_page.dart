import 'package:flutter/material.dart';

import '../models/exercise_model.dart';
import '../services/api_service.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final WgerApiService _apiService = WgerApiService();
  late Future<List<Exercise>> _exercises;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  void _loadExercises() {
    setState(() {
      _exercises = _apiService.fetchExercises();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Exercise>>(
      future: _exercises,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _ErrorView(onRetry: _loadExercises);
        }

        final exercises = snapshot.data ?? [];
        final filteredExercises = exercises.where((exercise) {
          final searchText = _searchTerm.toLowerCase();
          return exercise.name.toLowerCase().contains(searchText) ||
              exercise.category.toLowerCase().contains(searchText) ||
              exercise.muscles.any(
                (muscle) => muscle.toLowerCase().contains(searchText),
              );
        }).toList();

        return RefreshIndicator(
          onRefresh: () async => _loadExercises(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Exercise library',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search exercises',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() => _searchTerm = value);
                    },
                  ),
                ),
              ),
              if (filteredExercises.isEmpty)
                const SliverFillRemaining(
                  child: Center(child: Text('No exercises found.')),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.builder(
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      return _ExerciseCard(exercise: filteredExercises[index]);
                    },
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        );
      },
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(exercise.name),
        subtitle: Text(exercise.category),
        leading: CircleAvatar(
          child: Text(exercise.name.isEmpty ? '?' : exercise.name[0]),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(exercise.description),
          ),
          const SizedBox(height: 12),
          if (exercise.muscles.isNotEmpty)
            _InfoLine(label: 'Muscles', value: exercise.muscles.join(', ')),
          if (exercise.equipment.isNotEmpty)
            _InfoLine(label: 'Equipment', value: exercise.equipment.join(', ')),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('$label: $value'),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48),
            const SizedBox(height: 12),
            const Text('Exercises could not be loaded.'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
