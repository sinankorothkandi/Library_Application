import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/book/book_bloc.dart';
import 'package:library_application/data/repositories/book_repository.dart';
import 'package:library_application/presentation/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create an instance of the BookRepository
    final bookRepository = BookRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<BookBloc>(
          // Pass the repository instance to the BookBloc constructor
          create: (context) => BookBloc(bookRepository)..add(LoadBooksEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'My Flutter App',
        home: HomeScreen(),
      ),
    );
  }
}
