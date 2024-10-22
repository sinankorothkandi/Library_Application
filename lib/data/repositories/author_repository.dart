import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_application/data/models/author.dart';

class AuthorRepository {
  final String authorApiUrl = 'https://assessment.eltglobal.in/api/authors';

  // Fetch all authors
  Future<List<Author>> getAllAuthors() async {
    try {
      final response = await http.get(Uri.parse(authorApiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> authorsData = jsonResponse['result'];

          // Log the fetched authors data

          return authorsData.map((data) => Author.fromJson(data)).toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load authors from API');
      }
    } catch (error) {
      throw Exception('Failed to load authors: $error');
    }
  }
  // Add author function

 Future<Author?> addAuthor({
    required String name,
    required String birthdate,
    required String biography,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(authorApiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'birthdate': birthdate,
          'biography': biography,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Author.fromJson(jsonResponse);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }


  Future<Author?> getAuthorById(String authorId) async {
  if (authorId.isEmpty) {
    return null; 
  }
  try {
    final response = await http.get(Uri.parse('$authorApiUrl/$authorId'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Author.fromJson(jsonResponse);
    } else {
      return null;
    }
  } catch (error) {
    return null; 
  }
}



}
