class Exercise {
  final int id;
  final String name;
  final String description;

  Exercise({required this.id, required this.name, required this.description});

  // Teaches map/dictionary keys and data conversion
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as int,
      name: json['name'] as String,
      // The API description can sometimes be empty, so handle fallback defaults
      description: json['description'] as String? ?? 'No description provided.',
    );
  }
}
