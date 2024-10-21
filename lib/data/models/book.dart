
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
