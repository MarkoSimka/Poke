import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poke/models/app_user.dart';
import 'package:poke/screens/add_group_screen.dart';
import 'package:poke/screens/chat_screen.dart';
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
    const ChatPage(),
  ];

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Create an instance of Firestore.
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    AppUser user = AppUser(
        id: 1,
        name: 'test',
        nickName: 'testche',
        email: 'test@test.com',
        group_ids: []);
    // Convert the Product object to a map.
    Map<String, dynamic> userData = user.toMap();
    return users
        .add(userData)
        .then(
            (value) => print("Product added to Firestore with ID: ${value.id}"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Poke"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: addUser,
          ),
        ],
      ),
      body: _navPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomNavBar,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ]),
    );
  }
}
