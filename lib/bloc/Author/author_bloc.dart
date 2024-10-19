import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_application/data/models/author.dart';
import 'package:library_application/data/repositories/author_repository.dart';
part 'author_event.dart';
part 'author_state.dart';


class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final AuthorRepository authorRepository;

  AuthorBloc(this.authorRepository) : super(AuthorLoadingState()) {
    on<LoadAuthorsEvent>(_onLoadAuthors);
  }

  Future<void> _onLoadAuthors(LoadAuthorsEvent event, Emitter<AuthorState> emit) async {
    emit(AuthorLoadingState());
    try {
      final authors = await authorRepository.getAllAuthors();
      emit(AuthorLoadedState(authors));
    } catch (e) {
      emit(AuthorErrorState('Failed to load authors'));
    }
  }
}
