import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.backButton});

  final String title;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.blue,
      leading: _getBackButton(context)
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
}