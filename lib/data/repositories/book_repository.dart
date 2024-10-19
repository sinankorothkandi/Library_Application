import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_application/data/models/book.dart';
import 'package:library_application/data/models/author.dart';

class BookRepository {
  final String booksApiUrl = 'https://assessment.eltglobal.in/api/books';
  final String authorApiUrl = 'https://assessment.eltglobal.in/api/authors';

  // Fetch books and authors once, then map author IDs to author names
  Future<List<Book>> getBooks({int page = 1, int limit = 10}) async {
    try {
      // Fetch all authors first and cache them
      final authors = await _fetchAuthors();

      // Fetch books
      final response = await http.get(Uri.parse('$booksApiUrl?page=$page&limit=$limit'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> booksData = jsonResponse['result'];

          // Map the authorId to the corresponding author name
          return booksData.map((data) {
            final book = Book.fromJson(data);
            final authorName = authors[book.author] ?? 'Unknown Author';  // Find author name by ID, fallback if not found
            return book.copyWith(author: authorName);
          }).toList();
        } else {
          throw Exception('Invalid API response format: "result" field is missing or null');
        }
      } else {
        throw Exception('Failed to load books from API');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load books: $error');
    }
  }

  // Fetch all authors and create a map of authorId to authorName
  Future<Map<String, String>> _fetchAuthors() async {
    try {
      final response = await http.get(Uri.parse(authorApiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> authorsData = jsonResponse['result'];
          return {
            for (var author in authorsData)
              author['id']: author['name']  // Map authorId to authorName
          };
        } else {
          throw Exception('Invalid API response format: "result" field is missing or null');
        }
      } else {
        throw Exception('Failed to load authors from API');
      }
    } catch (error) {
      print('Error fetching authors: $error');
      throw Exception('Failed to load authors: $error');
    }
  }
}
