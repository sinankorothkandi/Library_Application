


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_application/bloc/author/author_bloc.dart';
import 'package:library_application/bloc/book/book_bloc.dart';
import 'package:library_application/data/repositories/author_repository.dart';
import 'package:library_application/data/repositories/book_repository.dart';
import 'package:library_application/presentation/screens/book_details.dart';
import 'package:library_application/presentation/screens/home_screen.dart';
import 'package:library_application/data/models/book.dart';
import 'package:library_application/presentation/widgets/custom_bottom_nav_bar.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Define routes using GoRouter
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MainPage(),  // Main page showing books
      ),
      GoRoute(
        path: '/book/:id',
        builder: (context, state) {
          final book = state.extra as Book;  // Pass the Book object as extra
          return BookDetailsPage(book: book);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Create instances of repositories
    final bookRepository = BookRepository();
    final authorRepository = AuthorRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<BookBloc>(
          create: (context) => BookBloc(
            bookRepository,
            authorRepository,
          )..add(LoadBooksEvent()),
        ),
        BlocProvider<AuthorBloc>(
          create: (context) => AuthorBloc(authorRepository)..add(LoadAuthorsEvent()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,  // Use routerConfig for GoRouter
        title: 'Library App',
      ),
    );
  }
}
