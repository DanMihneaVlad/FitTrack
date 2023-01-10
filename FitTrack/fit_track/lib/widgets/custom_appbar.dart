import 'package:fit_track/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.backButton, this.signOutButton = false});

  final String title;
  final bool backButton;
  final bool signOutButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      leading: _getBackButton(context),
      actions: <Widget>[
        _getSignOutButton(context)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget _getBackButton(BuildContext context) {
    if (backButton) {
      return IconButton(
        onPressed: () => Navigator.pop(context), 
        icon: Icon(Icons.keyboard_arrow_left)
      );
    } else {
      return Container();
    }
  }

  Widget _getSignOutButton(BuildContext context) {
    if (signOutButton) {
      
      final AuthService _auth = AuthService();

      return IconButton(
        onPressed: () async {
          await _auth.signOut();
        }, 
        tooltip: 'Sign out',
        icon: Icon(Icons.logout_outlined)
      );
    } else {
      return Container();
    }
  }
}