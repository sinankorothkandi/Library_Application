

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_application/data/models/book.dart';
import 'package:library_application/data/repositories/author_repository.dart';

class BookRepository {
  final String booksApiUrl = 'https://assessment.eltglobal.in/api/books';
  final AuthorRepository authorRepository = AuthorRepository();

  Future<List<Book>> getBooks({int page = 1, int limit = 10}) async {
    try {
      // Fetch all authors first before fetching books
      final authors = await authorRepository.getAllAuthors();
      
      final authorMap = {for (var author in authors) author.id: author.name};

      // Log the authorMap to ensure authors are fetched properly
      print('Author Map: $authorMap');

       final response = await http.get(Uri.parse('$booksApiUrl?page=$page&limit=$limit'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> booksData = jsonResponse['result'];
          
          // Map authorId to authorName in each book
          return booksData.map((data) {
            String authorId = data['authorId'];
            String authorName = authorMap[authorId] ?? 'Unknown';  
            return Book.fromJson(data, authorName); 
          }).toList();
        } else {
          throw Exception('Invalid API response format: "result" field is missing or null');
        }
      } else {
        throw Exception('Failed to load books from API');
      }
    } catch (error) {
      throw Exception('Failed to load books: $error');
    }
  }



  Future<List<Book>> searchBooks(String query, {int page = 1, int limit = 10}) async {
    try {
      final searchUrl = '$booksApiUrl?page=$page&limit=$limit&search=$query';


      final response = await http.get(Uri.parse(searchUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('result') && jsonResponse['result'] != null) {
          List<dynamic> booksData = jsonResponse['result'];

          // Fetch authors before mapping books
          final authors = await authorRepository.getAllAuthors();
          final authorMap = {for (var author in authors) author.id: author.name};

          // Log the authorMap for search

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

   Future<void> deleteBook(String bookId) async {
    final deleteUrl = '$booksApiUrl/$bookId';
    
    try {
      final response = await http.delete(Uri.parse(deleteUrl));

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to delete book');
      }
    } catch (error) {
      throw Exception('Failed to delete book: $error');
    }
  }

    Future<void> updateBook(String bookId, Map<String, dynamic> updateData) async {
    final updateUrl = '$booksApiUrl/$bookId';  
    
    try {
  
      final response = await http.patch(  
        Uri.parse(updateUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(updateData),
      );


      if (response.statusCode == 200) {
        print('Book updated successfully');
      } else {
        throw Exception('Server responded with status code: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (error) {
      print('Error updating book: $error');
      throw Exception('Failed to update book: $error');
    }
  }
}





