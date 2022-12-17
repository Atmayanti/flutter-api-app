import 'package:flutter/material.dart';
import 'package:api_app/services/logout_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final logout = LogoutService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              logout.postDataLogout().then(
                    (value) => Navigator.of(context).popAndPushNamed('/login'),
                  );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
