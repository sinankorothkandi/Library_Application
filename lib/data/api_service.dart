// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: 'https://assessment.eltglobal.in/api/'));

//   Future<List<dynamic>> getBooks() async {
//     final response = await _dio.get('/books');
//     return response.data;
//   }

//   Future<List<dynamic>> getAuthors() async {
//     final response = await _dio.get('/authors');
//     return response.data;
//   }

//   Future<void> addAuthor(Map<String, dynamic> author) async {
//     await _dio.post('/authors', data: author);
//   }

//   Future<void> updateAuthor(int id, Map<String, dynamic> author) async {
//     await _dio.patch('/authors/$id', data: author);
//   }

//   Future<void> deleteAuthor(int id) async {
//     await _dio.delete('/authors/$id');
//   }
// }
