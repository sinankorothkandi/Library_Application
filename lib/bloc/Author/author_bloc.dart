import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_application/data/models/author.dart';
import 'package:library_application/data/repositories/author_repository.dart';
part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final AuthorRepository authorRepository;

  AuthorBloc(this.authorRepository) : super(AuthorLoadingState()) {
    on<LoadAuthorsEvent>((event, emit) async {
      try {
        final authors = await authorRepository.getAuthors();
        emit(AuthorLoadedState(authors));
      } catch (e) {
        emit(AuthorErrorState('Failed to load authors'));
      }
    });

    on<AddAuthorEvent>((event, emit) async {
      try {
        await authorRepository.addAuthor(event.author);
        emit(AuthorAddedState(event.author));
      } catch (e) {
        emit(AuthorErrorState('Failed to add author'));
      }
    });

    on<UpdateAuthorEvent>((event, emit) async {
      try {
        await authorRepository.updateAuthor(event.id, event.updatedAuthor);
        emit(AuthorUpdatedState(event.updatedAuthor));
      } catch (e) {
        emit(AuthorErrorState('Failed to update author'));
      }
    });

    on<DeleteAuthorEvent>((event, emit) async {
      try {
        await authorRepository.deleteAuthor(event.id);
        emit(AuthorDeletedState(event.id));
      } catch (e) {
        emit(AuthorErrorState('Failed to delete author'));
      }
    });
  }
}
