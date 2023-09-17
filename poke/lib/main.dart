import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:poke/screens/login_screen.dart';
import 'package:poke/screens/register_screen.dart';
import 'firebase_options.dart';
// import 'package:poke/screens/home.dart';

Future<void> main() async {
  runApp(const MyApp());
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      debugShowCheckedModeBanner: false,
      title: 'Poke',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'Login',
      routes: {
        'Home': (context) => HomeScreen(), //Home
        'Login': (context) => const Login(), // Login
        'Register': (context) => const Register(), // Register
      },
    );
  }
}