import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poke/models/app_user.dart';
import 'package:poke/screens/account_screen.dart';
import 'package:poke/screens/add_group_screen.dart';
import 'package:poke/screens/home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _navPages = [
    const HomePage(),
    const AddGroupPage(),
    const AccountPage()
  ];

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Create an instance of Firestore.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(65, 86, 117, 1),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Poke"),
          ],
        ),
      ),
      body: _navPages[_selectedIndex],
      bottomNavigationBar:
        BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(65, 86, 117, 1),
          currentIndex: _selectedIndex,
          onTap: _navigateBottomNavBar,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          unselectedFontSize: 14,
          selectedItemColor: const Color.fromRGBO(242, 100, 25, 1),
          selectedFontSize: 14,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.white), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.white), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.white), label: "Account"),
          ]
      ),
    );
  }
}
