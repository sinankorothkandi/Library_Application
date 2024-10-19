// class Book {
//   final String id;
//   final String title;
//   final String author;  // Updated to hold the author name later
//   final String coverPictureURL;
//   final String description;
//   final double price;  // Add price field

//   Book({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.coverPictureURL,
//     required this.description,
//     required this.price,  // Add price to constructor
//   });

//   // Factory method to convert JSON to Book object
//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       id: json['id'],
//       title: json['title'],
//       author: json['authorId'],  // Initially hold authorId
//       coverPictureURL: json['coverPictureURL'],
//       description: json['description'],
//       price: json['price'],  // Make sure the 'price' field exists in the API response
//     );
//   }

//   // Method to update author after fetching name
//   Book copyWith({String? author}) {
//     return Book(
//       id: id,
//       title: title,
//       author: author ?? this.author,
//       coverPictureURL: coverPictureURL,
//       description: description,
//       price: price,  // Keep the price unchanged
//     );
//   }
// }

//========================================================
class Book {
  final String id;
  final String title;
  final String author;  // This should be initialized properly
  final String coverPictureURL;
  final String description;
  final double price;

  Book({
    required this.id,
    required this.title,
    required this.author,  // Make sure this is initialized
    required this.coverPictureURL,
    required this.description,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json, String authorName) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: authorName.isNotEmpty ? authorName : 'Unknown', // Ensure a fallback value
      coverPictureURL: json['coverPictureURL'] ?? '', // Provide a default value for URL
      description: json['description'] ?? '', // Provide a default value for description
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as double),
    );
  }

  // Implementing copyWith method
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverPictureURL,
    String? description,
    double? price,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverPictureURL: coverPictureURL ?? this.coverPictureURL,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }
}
