import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/providers/recipe_provider.dart';
import 'package:fit_track/screens/authenticate/authPage.dart';
import 'package:fit_track/screens/authenticate/loginPage.dart';
import 'package:fit_track/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User?>(context);

    if (user == null) {
      return AuthPage();
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext ctx) => RecipeProvider(uid: user.uid))
        ],
        child: HomePage()
      );
    }
  }
}