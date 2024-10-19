class Book {
  final String id;
  final String title;
  final String description;
  final String publishedDate;
  final String author;  // This will now hold the author name
  final String coverPictureURL;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.publishedDate,
    required this.author,
    required this.coverPictureURL,
  });

  // Factory constructor to create a Book object from a JSON map
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      publishedDate: json['publishedDate'],
      author: json['authorId'],  // Initially hold authorId, later replaced with name
      coverPictureURL: json['coverPictureURL'],
    );
  }

  // Copy the book object but replace the author name
  Book copyWith({String? author}) {
    return Book(
      id: id,
      title: title,
      description: description,
      publishedDate: publishedDate,
      author: author ?? this.author,  // Replace authorId with actual author name
      coverPictureURL: coverPictureURL,
    );
  }
}
