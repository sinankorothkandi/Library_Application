import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Library App ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                  context.read<BookBloc>().add(SearchBooksEvent(query: query));
                },
                decoration: InputDecoration(
                  hintText: 'Searchs...',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 241, 241, 241),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.black54),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  prefixIcon: const Icon(Icons.search),
                ),
                style: const TextStyle(color: Colors.black),
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
                return book.title
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
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
                  return GestureDetector(
                    onTap: (){
                       context.go('/book/${book.id}', extra: book);
                    },
                    child: Card(
                      
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              book.coverPictureURL,
                              fit: BoxFit.fitHeight,
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
                                Text('Author: ${book.author}',
                                    style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 4),
                                Text('Price: \$${book.price}',
                                    style: const TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
