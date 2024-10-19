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
          print('All Authors Fetched: $authorsData');

          return authorsData.map((data) => Author.fromJson(data)).toList();
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load authors from API');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load authors: $error');
    }
  }

  //====================================
  Future<Author?> getAuthorById(String authorId) async {
  if (authorId.isEmpty) {
    print('Error: authorId is empty.');
    return null; // Return null if the authorId is empty
  }
  try {
    final response = await http.get(Uri.parse('$authorApiUrl/$authorId'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Log the full response body
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Author.fromJson(jsonResponse);
    } else {
      print('Failed to load author: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error fetching author: $error');
    return null; // Handle errors gracefully
  }
}



}
