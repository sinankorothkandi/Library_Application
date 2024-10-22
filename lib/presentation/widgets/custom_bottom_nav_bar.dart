import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:library_application/presentation/screens/auther_screen.dart'; // Ensure this is the correct path
import 'package:library_application/presentation/screens/home_screen.dart'; // Ensure this is the correct path

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const BookPage(),
    const AuthorPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 233, 133, 2),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(EneftyIcons.home_2_outline),
            activeIcon: Icon(EneftyIcons.home_bold),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EneftyIcons.profile_circle_outline,
              size: 28,
            ),
            activeIcon: Icon(
              EneftyIcons.profile_circle_bold,
              size: 28,
            ),
            label: 'Authors',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
