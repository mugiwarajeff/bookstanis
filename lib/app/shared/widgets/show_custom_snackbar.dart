import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context,
    {required String message, Color color = Colors.green}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
  ));
}
