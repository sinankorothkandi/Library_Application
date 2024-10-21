

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_application/data/models/book.dart';
import 'package:library_application/data/repositories/author_repository.dart';
import 'package:library_application/data/repositories/book_repository.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc(this.bookRepository, AuthorRepository authorRepository) : super(BookLoadingState()) {
    on<LoadBooksEvent>(_onLoadBooks);
    on<SearchBooksEvent>(_onSearchBooks);
  }

  Future<void> _onLoadBooks(LoadBooksEvent event, Emitter<BookState> emit) async {
    emit(BookLoadingState());
    try {
      // Fetching books from the repository
      final books = await bookRepository.getBooks(page: event.page, limit: event.limit);
      emit(BookLoadedState(books));
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
