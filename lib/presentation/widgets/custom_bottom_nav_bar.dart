// import 'package:flutter/material.dart';

// class CustomBottomNavBar extends StatefulWidget {
//   @override
//   _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
// }

// class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.book),
//           label: 'Books',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Authors',
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:library_application/presentation/screens/auther_screen.dart'; // Ensure this is the correct path
import 'package:library_application/presentation/screens/home_screen.dart'; // Ensure this is the correct path

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Update to include the correct pages
  static List<Widget> _pages = <Widget>[
    BookPage(),  // Assuming HomeScreen is the first page
    AuthorPage(),  // Ensure AuthorPage is correctly imported
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Books', // Label for the first page
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Authors', // Label for the second page
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Update the selected page when tapped
      ),
    );
  }
}
