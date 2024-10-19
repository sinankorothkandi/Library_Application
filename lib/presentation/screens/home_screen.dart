import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/book/book_bloc.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load the books when the page is initialized
    context.read<BookBloc>().add(LoadBooksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book App'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
                context.read<BookBloc>().add(SearchBooksEvent(query: query));
              },
              decoration: InputDecoration(
                hintText: 'Search books or authors...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookLoadedState) {
            final books = state.books;

            // Filter books based on the search query
           final filteredBooks = books.where((book) {
  return book.title.toLowerCase().contains(searchQuery.toLowerCase());
  // Note: We won't filter by author here since we don't have author names yet
}).toList();



            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          book.coverPictureURL,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(book.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                          Text('Author: ${book.author}', style: const TextStyle(color: Colors.grey)),

                            const SizedBox(height: 4),
                            Text('Price: \$${book.price}',
                                style: const TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is BookErrorState) {
            print(state.errorMessage);
            return Center(child: Text(state.errorMessage));
          }
          return const Center(child: Text('No books available.'));
        },
      ),
    );
  }
}
