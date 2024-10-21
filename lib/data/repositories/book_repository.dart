
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:library_application/data/models/book.dart';
// import 'package:library_application/data/repositories/author_repository.dart';

// class BookRepository {
//   final String booksApiUrl = 'https://assessment.eltglobal.in/api/books';
//   final AuthorRepository authorRepository = AuthorRepository();

//   // Fetch books with pagination and resolve the correct author name
//   Future<List<Book>> getBooks({int page = 1, int limit = 10}) async {
//     try {
//       // Fetch all authors first
//       final authors = await authorRepository.getAllAuthors();
      
//       // Create a map with authorId as the key and authorName as the value
//       final authorMap = {for (var author in authors) author.id: author.name};

//       // Fetch books with pagination
//       final response = await http.get(Uri.parse('$booksApiUrl?page=$page&limit=$limit'));

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
//           List<dynamic> booksData = jsonResponse['result'];
          
//           // Replace authorId with authorName in each book
//           return booksData.map((data) {
//             String authorId = data['authorId'];  // Use the authorId here
//             String authorName = authorMap[authorId] ?? 'Unknown';  // Look up the authorId in authorMap
//             return Book.fromJson(data, authorName);  // Pass the authorName to Book
//           }).toList();
//         } else {
//           throw Exception('Invalid API response format: "result" field is missing or null');
//         }
//       } else {
//         throw Exception('Failed to load books from API');
//       }
//     } catch (error) {
//       print('Error: $error');
//       throw Exception('Failed to load books: $error');
//     }
//   }

//   // Search books based on query and resolve the correct author name
//   Future<List<Book>> searchBooks(String query, {int page = 1, int limit = 10}) async {
//     try {
//       final searchUrl = '$booksApiUrl?page=$page&limit=$limit&search=$query';

//       // Log the search URL for debugging
//       print('Search URL: $searchUrl');

//       final response = await http.get(Uri.parse(searchUrl));

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
//           List<dynamic> booksData = jsonResponse['result'];

//           final authors = await authorRepository.getAllAuthors();
//           final authorMap = {for (var author in authors) author.id: author.name};

//           return booksData.map((data) {
//             String authorId = data['authorId'];  // Use authorId for lookup
//             String authorName = authorMap[authorId] ?? 'Unknown';  // Get the authorName using the authorId
//             return Book.fromJson(data, authorName);  // Pass authorName instead of authorId
//           }).toList();
//         } else {
//           throw Exception('Invalid API response format: "result" field is missing or null');
//         }
//       } else {
//         throw Exception('Failed to search books from API');
//       }
//     } catch (error) {
//       print('Error during search: $error');
//       throw Exception('Failed to search books: $error');
//     }
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_application/data/models/book.dart';
import 'package:library_application/data/repositories/author_repository.dart';

class BookRepository {
  final String booksApiUrl = 'https://assessment.eltglobal.in/api/books';
  final AuthorRepository authorRepository = AuthorRepository();

  // Fetch books with pagination and resolve the correct author name
  Future<List<Book>> getBooks({int page = 1, int limit = 10}) async {
    try {
      // Fetch all authors first before fetching books
      final authors = await authorRepository.getAllAuthors();
      
      // Create a map with authorId as the key and authorName as the value
      final authorMap = {for (var author in authors) author.id: author.name};

      // Log the authorMap to ensure authors are fetched properly
      print('Author Map: $authorMap');

      // Fetch books with pagination
      final response = await http.get(Uri.parse('$booksApiUrl?page=$page&limit=$limit'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> booksData = jsonResponse['result'];
          
          // Map authorId to authorName in each book
          return booksData.map((data) {
            String authorId = data['authorId'];
            String authorName = authorMap[authorId] ?? 'Unknown';  // Use authorId for lookup
            return Book.fromJson(data, authorName);  // Pass authorName to the Book model
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

  // Search books based on query and resolve the correct author name
  Future<List<Book>> searchBooks(String query, {int page = 1, int limit = 10}) async {
    try {
      final searchUrl = '$booksApiUrl?page=$page&limit=$limit&search=$query';

      // Log the search URL for debugging
      print('Search URL: $searchUrl');

      final response = await http.get(Uri.parse(searchUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> booksData = jsonResponse['result'];

          // Fetch authors before mapping books
          final authors = await authorRepository.getAllAuthors();
          final authorMap = {for (var author in authors) author.id: author.name};

          // Log the authorMap for search
          print('Author Map for Search: $authorMap');

          return booksData.map((data) {
            String authorId = data['authorId'];
            String authorName = authorMap[authorId] ?? 'Unknown';  // Use authorId for lookup
            return Book.fromJson(data, authorName);  // Pass authorName to Book
          }).toList();
        } else {
          throw Exception('Invalid API response format: "result" field is missing or null');
        }
      } else {
        throw Exception('Failed to search books from API');
      }
    } catch (error) {
      print('Error during search: $error');
      throw Exception('Failed to search books: $error');
    }
  }
}
