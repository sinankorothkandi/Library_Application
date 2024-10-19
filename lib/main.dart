// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:library_application/bloc/book/book_bloc.dart';
// import 'package:library_application/data/repositories/author_repository.dart';
// import 'package:library_application/data/repositories/book_repository.dart';
// import 'package:library_application/presentation/screens/home_screen.dart';
// import 'package:library_application/presentation/widgets/custom_bottom_nav_bar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Create an instance of the BookRepository
//     final bookRepository = BookRepository();
//     final authorRepository = AuthorRepository();

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<BookBloc>(
//           create: (context) => BookBloc(
//             bookRepository,
//             authorRepository, // Add this
//           )..add(LoadBooksEvent()),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'My Flutter App',
//         home: MainPage(),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/author/author_bloc.dart';
import 'package:library_application/bloc/book/book_bloc.dart';
import 'package:library_application/data/repositories/author_repository.dart';
import 'package:library_application/data/repositories/book_repository.dart';
import 'package:library_application/presentation/widgets/custom_bottom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider<AuthorBloc>( // Add this line
          create: (context) => AuthorBloc(authorRepository)..add(LoadAuthorsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Flutter App',
        home: MainPage(),
      ),
    );
  }
}
