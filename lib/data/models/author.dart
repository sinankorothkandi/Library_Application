class Author {
  final String id;
  final String name;
  final String birthdate;
  final String biography;

  Author({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.biography,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 'Unknown', 
      name: json['name'] ?? 'Unknown', 
      birthdate: json['birthdate'] ?? 'Unknown', 
      biography: json['biography'] ?? 'No biography available', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthdate': birthdate,
      'biography': biography,
    };
  }
}
