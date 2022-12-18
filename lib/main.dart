import 'package:api_app/views/createcategorypage.dart';
import 'package:api_app/views/editcategorypage.dart';
import 'package:api_app/views/homepage.dart';
import 'package:api_app/views/loginpage.dart';
import 'package:api_app/views/registerpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homepage': (context) => const HomePage(),
        '/login': (context) => const MainApp(),
        '/register': (context) => const Register(),
        '/category/add': (context) => const AddCategory(),
        '/category/update': (context) => const UpdateCategory(),
      },
      home: const LoginPage(),
    );
  }
}