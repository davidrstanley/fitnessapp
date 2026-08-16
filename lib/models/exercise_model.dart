class Exercise {
  final int id;
  final String name;
  final String description;
  final String category;
  final List<String> muscles;
  final List<String> equipment;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.muscles,
    required this.equipment,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    final translations = (json['translations'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();
    final translation = translations.firstWhere(
      (item) => item['language'] == 2,
      orElse: () => translations.isNotEmpty ? translations.first : {},
    );

    final category = json['category'] as Map<String, dynamic>?;
    final muscles = (json['muscles'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((muscle) => muscle['name'] as String? ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    final equipment = (json['equipment'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map((item) => item['name'] as String? ?? '')
        .where((name) => name.isNotEmpty)
        .toList();

    return Exercise(
      id: json['id'] as int,
      name: translation['name'] as String? ?? 'Unnamed exercise',
      description:
          translation['description'] as String? ?? 'No description provided.',
      category: category?['name'] as String? ?? 'Uncategorized',
      muscles: muscles,
      equipment: equipment,
    );
  }
}
