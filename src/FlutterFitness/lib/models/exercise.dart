class Exercise {
  // Creating 2 variables to hold the name and category of the exercise
  final String name;
  final String category;
  final String level;
  final String equipment;

  // This receives the values and assigns them to our variables (required)
  Exercise({
    required this.name,
    required this.category,
    required this.level,
    required this.equipment,
  });

  // This grabs the data from the opened JSON file and passes it to the constructor
  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      level: json['level'] ?? '',
      equipment: json['equipment'] ?? '',
    );
  }
}