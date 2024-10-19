import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/author/author_bloc.dart';

class AuthorPage extends StatefulWidget {
  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  void initState() {
    super.initState();
    // Load authors when the page is initialized
    context.read<AuthorBloc>().add(LoadAuthorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Authors'),
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
                  leading: CircleAvatar(
                    child: Text(author.name[0]),  // First letter of the author name
                  ),
                  title: Text(author.name),
                  subtitle: Text(author.biography),
                );
              },
            );
          } else if (state is AuthorErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No authors available.'));
        },
      ),
    );
  }
}
