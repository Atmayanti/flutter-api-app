import 'package:api_app/services/login_service.dart';
import 'package:api_app/views/homepage.dart';
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
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginService loginService = LoginService();
  final _loginKey = GlobalKey<FormState>();
  bool isLoginFalse = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EEFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFF424874),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Login Page',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Image(
                      width: 300,
                      image: AssetImage(
                        '../../assets/login.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                    },
                    controller: _emailController,
                    cursorColor: const Color(0xFF424874),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    cursorColor: const Color(0xFF424874),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 15),
                    child: MaterialButton(
                      color: const Color(0xFF424874),
                      onPressed: () async {
                        if (_loginKey.currentState!.validate()) {
                          bool response = await loginService.postData(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (response) {
                            Navigator.of(context).popAndPushNamed('/homepage');
                          } else {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Failed Login'),
                                  backgroundColor: Color(0xFFDCD6F7),
                                  content:
                                      const Text('Incorrect email or password'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK', style: TextStyle(color: Color(0xFF424874)),),
                                    ),
                                  ],
                                ),
                              // child: const Text('Show Dialog'),
                            );
                            setState(() {
                              isLoginFalse = true;
                            });
                          }
                        }
                      },
                      minWidth: 500,
                      height: 60,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFFF4EEFF), fontSize: 20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                            const Color(0xFF424874),
                          ),
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            color: Color(0xFF424874),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
