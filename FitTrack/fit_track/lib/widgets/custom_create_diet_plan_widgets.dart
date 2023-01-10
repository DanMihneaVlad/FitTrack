import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCreateDietPlanWidgets {
  List<Widget> createWidgets(String message) {
    return [
      Icon(
        Icons.error_outline,
        color: Colors.green,
        size: 60.0,
      ),
      const SizedBox(height: 20),
      Container(
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }
}
