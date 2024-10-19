
// class Author {
//   final String id;
//   final String name;
//   final String birthdate; // Store birthdate as a String (you can format it if needed)
//   final String biography;

//   Author({
//     required this.id,
//     required this.name,
//     required this.birthdate,
//     required this.biography,
//   });

//   // Factory constructor to create an Author object from JSON
//   factory Author.fromJson(Map<String, dynamic> json) {
//     return Author(
//       id: json['id'],
//       name: json['name'],
//       birthdate: json['birthdate'],  // Make sure to map 'birthdate'
//       biography: json['biography'],  // Make sure to map 'biography'
//     );
//   }
// }
//======================================


class Author {
  final String id;
  final String name;
  final String birthdate; // Store birthdate as a String (you can format it if needed)
  final String biography;

  Author({
    required this.id,
    required this.name,
    required this.birthdate,
    required this.biography,
  });

  // Factory constructor to create an Author object from JSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 'Unknown', // Handle null values
      name: json['name'] ?? 'Unknown', // Handle null values
      birthdate: json['birthdate'] ?? 'Unknown', // Handle null values
      biography: json['biography'] ?? 'No biography available', // Handle null values
    );
  }
}
