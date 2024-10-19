import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/book/book_bloc.dart';
import 'package:library_application/presentation/screens/auther_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the event to load books when the screen is initialized
    context.read<BookBloc>().add(LoadBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AuthorsPage()));
              },
              icon: Icon(Icons.abc))
        ],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BookLoadedState) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return ListTile(
                  leading: Image.network(book.coverPictureURL),
                  title: Text(book.title),
                  subtitle: Text(book.author), // Display author name
                );
              },
            );
          } else if (state is BookErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          return Center(
            child: Text('No books available'),
          );
        },
      ),
    );
  }
}
