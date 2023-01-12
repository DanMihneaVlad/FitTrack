import 'package:fit_track/screens/home/home_page.dart';
import 'package:fit_track/screens/meals/meals_page.dart';
import 'package:fit_track/screens/profile/profile_page.dart';
import 'package:fit_track/screens/recipes/recipes.dart';
import 'package:fit_track/services/auth.dart';
import 'package:fit_track/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final AuthService _auth = AuthService();

  // The 4 main application screens
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Home', Icons.home, Colors.teal),
    Destination(1, 'Meals', Icons.dinner_dining, Colors.orange),
    Destination(2, 'Recipes', Icons.restaurant_menu_sharp, Colors.amber),
    Destination(3, 'Profile', Icons.person, Colors.blue),
  ];

  int currentPageIndex = 0;

  final screens = [
    HomePage(),
    MealsPage(),
    RecipesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: allDestinations[currentPageIndex].title, backButton: false, signOutButton: true),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: allDestinations.map((Destination destination) {
          return NavigationDestination(
            icon: Icon(destination.icon, color: destination.color), 
            label: destination.title
          );
        }).toList(),
      ),
      body: screens[currentPageIndex]
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.icon, this.color);
  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
}