import 'package:flutter/cupertino.dart';

class CustomBottomSheet {
  Widget createCustomBottomSheet(String message) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        Text(
          message,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}