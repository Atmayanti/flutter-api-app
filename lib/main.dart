import 'package:api_app/services/login_service.dart';
import 'package:api_app/views/homepage.dart';
import 'package:api_app/views/loginpage.dart';
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
        '/homepage': (context) => HomePage(),
        '/login': (context) => MainApp(),
      },
      home: LoginPage(),
    );
  }
}