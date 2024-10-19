part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookLoadingState extends BookState {}

class BookLoadedState extends BookState {
  final List<Book> books;

  BookLoadedState(this.books);

  @override
  List<Object?> get props => [books];
}

class BookAddedState extends BookState {
  final Book book;

  BookAddedState(this.book);

  @override
  List<Object?> get props => [book];
}

class BookUpdatedState extends BookState {
  final Book updatedBook;

  BookUpdatedState(this.updatedBook);

  @override
  List<Object?> get props => [updatedBook];
}

class BookDeletedState extends BookState {
  final int bookId;

  BookDeletedState(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class BookErrorState extends BookState {
  final String errorMessage;

  // Constructor that requires the errorMessage
  BookErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
