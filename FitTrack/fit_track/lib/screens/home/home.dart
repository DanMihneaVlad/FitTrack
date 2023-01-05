import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logged in'),
            MaterialButton(
              onPressed: () {
                _auth.signOut();
              },
              color: Colors.green,
              child: Text('Log out'),
            )
          ]
        ),
      )
    );
  }
}