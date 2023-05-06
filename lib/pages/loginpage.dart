import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // user sign in function
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // user sign in error function
    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepOrange,
            title: Center(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          );
        },
      );
    }

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // show error message (wrong email/pass)
      showErrorMessage(e.code);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Color.fromRGBO(224, 224, 224, 1),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.radio_button_unchecked,
                        size: 100,
                        color: Colors.black,
                      ),
                      Text("MyCircle",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 60, color: Colors.black,)),
                    ],
                  ),
                  const SizedBox(height: 50),

                  // welcome back text
                  const Text("Welcome back!",
                      style: TextStyle(
                        color: Color.fromARGB(255, 79, 77, 77),
                        fontSize: 16,
                      )),
                  const SizedBox(height: 30),

                  // username textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Username",
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  // forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Username/Password?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: signUserIn,
                    message: "Sign In",
                  ),
                  const SizedBox(height: 50),

                  // New user? Register link text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?",
                          style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}