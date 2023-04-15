import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../classes/userdata.dart';
import 'homepage.dart';
import 'loginorregister.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    UserData userData;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // authorized state changes
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return HomePage(); // if cred correct, navigate to homepage
          }
          //user not logged in
          else {
            return LoginOrRegisterPage(); // return login or register toggle pages
          }
        },
      ),
    );
  }
}
