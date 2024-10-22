import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:library_application/bloc/author/author_bloc.dart';
import 'package:library_application/bloc/book/book_bloc.dart';
import 'package:library_application/data/repositories/author_repository.dart';
import 'package:library_application/data/repositories/book_repository.dart';
import 'package:library_application/presentation/screens/EditBookPage.dart';
import 'package:library_application/presentation/screens/book_details.dart';
import 'package:library_application/data/models/book.dart';
import 'package:library_application/presentation/screens/splash_screen.dart';
import 'package:library_application/presentation/widgets/custom_bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const SplashScreen(), 
      ),
      GoRoute(
        path: '/nav',
        builder: (context, state) =>
            const MainPage(), 
      ),
      GoRoute(
        path: '/book/:id',
        builder: (context, state) {
          final book = state.extra as Book; 
          return BookDetailsPage(book: book);
        },
      ),
      GoRoute(
        path: '/book/:id/edit',
        builder: (context, state) => EditBookPage(
          book: state.extra as Book,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
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
          create: (context) =>
              AuthorBloc(authorRepository)..add(LoadAuthorsEvent()),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          cardTheme: CardTheme(
            color: const Color.fromARGB(255, 252, 252, 252),
            shadowColor:
                const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routerConfig: _router, 
        title: 'Library App',
      ),
    );
  }
}
