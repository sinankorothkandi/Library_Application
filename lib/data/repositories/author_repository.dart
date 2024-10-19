import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_application/data/models/author.dart';

class AuthorRepository {
  final String authorApiUrl = 'https://assessment.eltglobal.in/api/authors';

  // Fetch all authors
  Future<List<Author>> getAuthors() async {
    try {
      final response = await http.get(Uri.parse(authorApiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> authorsData = jsonResponse['result']; // Assuming 'result' contains the list

        return authorsData.map((data) => Author.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load authors');
      }
    } catch (error) {
      throw Exception('Failed to load authors: $error');
    }
  }

  // Add an author (you may implement this if needed)
  Future<void> addAuthor(Author author) async {
    // Implement API call to add an author if required
    // POST request with author data
  }

  // Update an author by ID (you may implement this if needed)
  Future<void> updateAuthor(int id, Author updatedAuthor) async {
    // Implement API call to update an author if required
    // PUT request with updated author data
  }

  // Delete an author by ID
  Future<void> deleteAuthor(int id) async {
    try {
      final response = await http.delete(Uri.parse('$authorApiUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete author');
      }
    } catch (error) {
      throw Exception('Failed to delete author: $error');
    }
  }
}
