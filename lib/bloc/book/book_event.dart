part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBooksEvent extends BookEvent {
  final int page;
  final int limit;

  LoadBooksEvent({this.page = 1, this.limit = 10});

  @override
  List<Object> get props => [page, limit];
}
class AddBookEvent extends BookEvent {
  final Book book;

  AddBookEvent(this.book);

  @override
  List<Object?> get props => [book];
}
class SearchBooksEvent extends BookEvent {
  final String query;

  SearchBooksEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
class UpdateBookEvent extends BookEvent {
  final int id;
  final Book updatedBook;

  UpdateBookEvent(this.id, this.updatedBook);

  @override
  List<Object?> get props => [id, updatedBook];
}

class DeleteBookEvent extends BookEvent {
  final int id;

  DeleteBookEvent(this.id);

  @override
  List<Object?> get props => [id];
}
