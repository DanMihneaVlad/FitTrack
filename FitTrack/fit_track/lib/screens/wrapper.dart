import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_track/providers/recipe_provider.dart';
import 'package:fit_track/screens/authenticate/authPage.dart';
import 'package:fit_track/screens/authenticate/loginPage.dart';
import 'package:fit_track/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const AuthPage();
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RecipeProvider(uid: user.uid))
        ],
        child: const MainPage()
      );
    }
  }
}