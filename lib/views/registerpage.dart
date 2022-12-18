import 'package:api_app/services/register_service.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final _registerKey = GlobalKey<FormState>();

  RegisterService registerService = RegisterService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF424874),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Register Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _registerKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
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
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      } else if (value.length < 8) {
                        return 'Password should more than 8 characters';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password confirmation is required';
                      } else if (value.length < 8) {
                        return 'Password confirmation should more than 8 characters';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _confirmpasswordController,
                    decoration: const InputDecoration(
                      hintText: 'Password Confirmation',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 40, 0, 15),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_registerKey.currentState!.validate()) {
                          bool response = await registerService.postRegister(
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _confirmpasswordController.text,
                          );
                          if (response) {
                            Navigator.of(context).popAndPushNamed('/login');
                          } else {}
                        }
                      },
                      color: const Color(0xFF424874),
                      minWidth: 500,
                      height: 60,
                      child: Text(
                        "Register",
                        style:
                            const TextStyle(color: const Color(0xFFF4EEFF), fontSize: 20),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                            const Color(0xFF424874),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF424874),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
