part of 'author_bloc.dart';

abstract class AuthorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthorLoadingState extends AuthorState {}

class AuthorLoadedState extends AuthorState {
  final List<Author> authors;

  AuthorLoadedState(this.authors);

  @override
  List<Object?> get props => [authors];
}

class AuthorAddedState extends AuthorState {
  final Author author;

  AuthorAddedState(this.author);

  @override
  List<Object?> get props => [author];
}

class AuthorUpdatedState extends AuthorState {
  final Author updatedAuthor;

  AuthorUpdatedState(this.updatedAuthor);

  @override
  List<Object?> get props => [updatedAuthor];
}

class AuthorDeletedState extends AuthorState {
  final int authorId;

  AuthorDeletedState(this.authorId);

  @override
  List<Object?> get props => [authorId];
}

class AuthorErrorState extends AuthorState {
  final String message;

  AuthorErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
