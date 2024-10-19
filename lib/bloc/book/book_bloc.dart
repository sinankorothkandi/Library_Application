import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_application/data/models/book.dart';
import 'package:library_application/data/repositories/author_repository.dart';
import 'package:library_application/data/repositories/book_repository.dart';

part 'book_event.dart';
part 'book_state.dart';
class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;
  final AuthorRepository authorRepository;

  BookBloc(this.bookRepository, this.authorRepository) : super(BookLoadingState()) {
    on<LoadBooksEvent>(_onLoadBooks);
    on<SearchBooksEvent>(_onSearchBooks);
  }
Future<void> _onLoadBooks(LoadBooksEvent event, Emitter<BookState> emit) async {
  emit(BookLoadingState());
  try {
    // Fetching books from the repository
    final books = await bookRepository.getBooks(page: event.page, limit: event.limit);
    
    // Print the fetched books for debugging
    print('Fetched Books: $books');

    // Fetch all authors once and store them
    final allAuthors = await authorRepository.getAllAuthors();
    final authorsMap = { for (var author in allAuthors) author.id: author.name }; // Map for quick access

    // Log the authorsMap for debugging
    print('Authors Map: $authorsMap');

    final booksWithAuthors = await Future.wait(books.map((book) async {
      if (book.author != null && book.author!.isNotEmpty) {
        print('Fetching author for ID: ${book.author}'); // Log the authorId being fetched
        
        // Check if the author exists in the authorsMap
        String authorName = authorsMap[book.author!] ?? 'Unknown';
        
        // Log the fetched author name
        print('Author Name for ID ${book.author}: $authorName');
        
        return book.copyWith(author: authorName);
      } else {
        print('No valid authorId found for book: ${book.title}');
        return book.copyWith(author: 'Unknown'); // Handle unknown author case
      }
    }).toList());

    emit(BookLoadedState(booksWithAuthors));
  } catch (e) {
    emit(BookErrorState('Failed to load books: $e'));
  }
}



  Future<void> _onSearchBooks(SearchBooksEvent event, Emitter<BookState> emit) async {
    emit(BookLoadingState());
    try {
      final books = await bookRepository.searchBooks(event.query);
      emit(BookLoadedState(books));
    } catch (e) {
      emit(BookErrorState('Failed to search books: $e'));
    }
  }
}
