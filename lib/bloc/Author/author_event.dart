part of 'author_bloc.dart';

abstract class AuthorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAuthorsEvent extends AuthorEvent {}

class AddAuthorEvent extends AuthorEvent {
  final Author author;

  AddAuthorEvent(this.author);

  @override
  List<Object?> get props => [author];
}

class UpdateAuthorEvent extends AuthorEvent {
  final int id;
  final Author updatedAuthor;

  UpdateAuthorEvent(this.id, this.updatedAuthor);

  @override
  List<Object?> get props => [id, updatedAuthor];
}

class DeleteAuthorEvent extends AuthorEvent {
  final int id;

  DeleteAuthorEvent(this.id);

  @override
  List<Object?> get props => [id];
}
