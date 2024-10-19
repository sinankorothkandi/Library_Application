import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/Author/author_bloc.dart';

class AuthorsPage extends StatefulWidget {
  @override
  _AuthorsPageState createState() => _AuthorsPageState();
}

class _AuthorsPageState extends State<AuthorsPage> {
  @override
  void initState() {
    super.initState();
    // Trigger the event to load authors when the screen is initialized
    context.read<AuthorBloc>().add(LoadAuthorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors List'),
      ),
      body: BlocBuilder<AuthorBloc, AuthorState>(
        builder: (context, state) {
          if (state is AuthorLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthorLoadedState) {
            return ListView.builder(
              itemCount: state.authors.length,
              itemBuilder: (context, index) {
                final author = state.authors[index];
                return ListTile(
                  title: Text(author.name),
                );
              },
            );
          } else if (state is AuthorErrorState) {
            return Center(child: Text(state.message));
          }

          // Default case when no authors are available
          return Center(child: Text('No authors available.'));
        },
      ),
    );
  }
}
