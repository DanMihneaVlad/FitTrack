import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/screens/authenticate/authPage.dart';
import 'package:fit_track/screens/authenticate/loginPage.dart';
import 'package:fit_track/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthPage();
          }
        }
      ),
    );
  }
}