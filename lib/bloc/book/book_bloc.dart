import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_application/data/models/book.dart';
import 'package:library_application/data/repositories/book_repository.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc(this.bookRepository) : super(BookLoadingState()) {
    // Register the LoadBooksEvent event handler using the on<Event> method
    on<LoadBooksEvent>(_onLoadBooks);
  }

  // Event handler for loading books
  Future<void> _onLoadBooks(LoadBooksEvent event, Emitter<BookState> emit) async {
    emit(BookLoadingState());
    try {
      // Fetch books from the repository with pagination
      final books = await bookRepository.getBooks(page: event.page, limit: event.limit);
      if (books.isNotEmpty) {
        emit(BookLoadedState(books));
      } else {
        emit(BookErrorState('No books available.'));
      }
    } catch (e) {
      emit(BookErrorState('Failed to load books. Please check your internet connection.'));
    }
  }
}
