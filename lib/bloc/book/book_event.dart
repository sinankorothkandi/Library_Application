part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBooksEvent extends BookEvent {
  final int page;
  final int limit;

  LoadBooksEvent({this.page = 1, this.limit = 10});
}
class AddBookEvent extends BookEvent {
  final Book book;

  AddBookEvent(this.book);

  @override
  List<Object?> get props => [book];
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
