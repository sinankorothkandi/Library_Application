import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_application/bloc/author/author_bloc.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

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
        title: const Text(
          'Authors',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: BlocBuilder<AuthorBloc, AuthorState>(
        builder: (context, state) {
          if (state is AuthorLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthorLoadedState) {
            return ListView.builder(
              itemCount: state.authors.length,
              itemBuilder: (context, index) {
                final author = state.authors[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0), // Margin around each container
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                          author.name[0]), // First letter of the author name
                    ),
                    title: Text(author.name),
                    subtitle: Text(
                      author.biography,
                      maxLines: 2, // Limit to two lines
                      overflow:
                          TextOverflow.ellipsis, // Show ellipsis for overflow
                    ),
                  ),
                );
              },
            );
          } else if (state is AuthorErrorState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No authors available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAuthorBottomSheet(context);
        },
        backgroundColor: Colors.black, // Set the background color to black
        foregroundColor: Colors.white, // Set the icon color to white
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _showAddAuthorBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Add author',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Author Name',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 201, 201, 201), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:  Color.fromARGB(255, 255, 119, 7), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const TextField(
            maxLines: 8,
            decoration: InputDecoration(
              // labelText: 'Biography',
              hintText: 'Biography',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 201, 201, 201), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 255, 119, 7), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'DOB',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 201, 201, 201), width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 119, 7), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Add Author logic
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[900], // Background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(9.0), // Adjust the radius here
                ),
              ),
              child: const Text(
                'Add Author',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
